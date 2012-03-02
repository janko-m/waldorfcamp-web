require 'active_support/core_ext/hash/keys'
require 'yajl'

helpers do
  include Sinatra::Partials

  def navigation_pages
    json_file = File.open("#{settings.root}/data/navigation.json")
    Yajl::Parser.new.parse(json_file).collect { |hash| hash.symbolize_keys }
  end

  def current_page?(page)
    request.path_info == page[:route]
  end

  def workshops
    json_file = File.open("#{settings.root}/data/workshops.json")
    Yajl::Parser.new.parse(json_file)
  end

  def camps
    json_file = File.open("#{settings.root}/data/camps.json")
    Yajl::Parser.new.parse(json_file).collect { |hash| hash.symbolize_keys }
  end
end
