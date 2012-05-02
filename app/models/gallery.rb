class Gallery
  USER_NSID = '66667715@N07'.freeze
  DEFAULT_CAMP = '2001-badija'.freeze
  EXTRAS = %w[url_sq url_t url_s url_q url_m url_n url_z url_c url_l url_o].freeze

  def self.camps
    @camps ||= Flickrie.sets_from_user(USER_NSID).
      sort_by do |set|
        year, island = parse_set_title(set.title)
        year
      end
  end

  def self.current_camp(url_title)
    url_title ||= DEFAULT_CAMP
    current_camp_title = parse_url_title(url_title).join(', ')
    camps.find { |camp| camp.title == current_camp_title }
  end

  def self.photos_from_camp(camp)
    camp.photos(:extras => EXTRAS)
  end

  private

  def self.parse_url_title(url_title)
    year, island = url_title.split('-')
    [year.to_i, island.capitalize]
  end

  def self.parse_set_title(set_title)
    year, island = set_title.split(', ')
    [year.to_i, island]
  end
end
