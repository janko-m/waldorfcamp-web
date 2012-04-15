require 'faraday_stack'
require 'securerandom'
require 'active_support/notifications'
require 'active_support/cache'

ActiveSupport::Notifications.subscribe('request.faraday') do |name, start_time, end_time, _, env|
  url = env[:url]
  http_method = env[:method].to_s.upcase
  duration = end_time - start_time
  $stderr.puts '[%s] %s %s (%.3f s)' % [url.host, http_method, url.request_uri, duration]
end

module Flickr
  def self.client
    @client ||= begin
      client = FaradayStack.build Client,
        :url => 'http://api.flickr.com/services/rest/',
        :params => {
          :format => 'json',
          :nojsoncallback => '1',
          :api_key => ENV['FLICKR_API_KEY']
        },
        :request => {
          :open_timeout => 10,
          :timeout => 10
        }

      cache = ActiveSupport::Cache::FileStore.new File.join(ENV['TMPDIR'], 'waldorf-cache'),
          namespace: 'waldorf', expires_in: 60 * 60 * 24 * 7

      client.builder.insert_before FaradayStack::ResponseJSON, FaradayStack::Caching,
          cache, strip_params: %w[ api_key format nojsoncallback ]

      client.builder.insert_before FaradayStack::ResponseJSON, FaradayStack::Instrumentation
      client.builder.insert_before FaradayStack::ResponseJSON, StatusCheck
      client
    end
  end

  class Error < StandardError
  end

  class StatusCheck < Faraday::Response::Middleware
    def on_complete(env)
      if env[:body]['stat'] != 'ok'
        raise Error, env[:body]['message']
      end
    end
  end

  class Client < Faraday::Connection
    def get(method, params = {})
      super() do |req|
        req.params[:method] = method
        req.params.update(params)
      end
    end

    def media_from_set(set_id, params = {})
      default_params = {
        :photoset_id => set_id,
        :extras => 'media'
      }
      get 'flickr.photosets.getPhotos', default_params.merge(params)
    end

    def photos_from_set(set_id)
      media_from_set set_id, :media => 'photos',
        :extras => 'url_sq,url_q,url_t,url_s,url_n,url_m,url_z,url_c,url_l,url_o,media'
    end

    def videos_from_set(set_id)
      media_from_set set_id, :media => 'videos'
    end

    def sets_from_user(user_id)
      get 'flickr.photosets.getList', :user_id => user_id
    end

    def find_user_by_email(email)
      get 'flickr.people.findByEmail', :find_email => email
    end

    def find_user_by_username(username)
      get 'flickr.people.findByUsername', :username => username
    end

    def get_user_info(user_id)
      get 'flickr.people.getInfo', :user_id => user_id
    end

    def get_set_info(set_id)
      get 'flickr.photosets.getInfo', :photoset_id => set_id
    end

    def get_media_info(media_id)
      get 'flickr.photos.getInfo', :photo_id => media_id
    end

    def get_licenses
      get 'flickr.photos.licenses.getInfo'
    end
  end
end
