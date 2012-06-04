class Camp
  class << self
    def all
      @camps ||= Flickrie.sets_from_user('66667715@N07').sort_by do |set|
        year, island = set.title.split(', ')
        year
      end
    end

    def find_by_url_title(url_title)
      title = url_title.split('-').map(&:capitalize).join(', ')
      camp = @camps.find { |camp| camp.title == title }
      def camp.photos(params = {})
        super(params.merge(:include_sizes => true)).each(&:small320!)
      end
      camp
    end
  end
end
