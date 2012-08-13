class Camp
  def initialize(set)
    @set = set
  end

  def title
    @set.title
  end

  def photos(params = {})
    @set.photos(params)
  end

  def year
    title.split(", ").first
  end

  def island
    title.split(", ").last
  end

  def to_param
    title.parameterize
  end

  def self.all
    @camps ||= flickr_sets.map { |set| new(set) }
  end

  def self.find(url_title)
    all.find { |camp| camp.title.parameterize == url_title }
  end

  private

  def self.flickr_sets
    Flickrie.sets_from_user("66667715@N07")
      .map do |set|
        set.instance_eval do
          def photos(params = {})
            super(params.merge(include_sizes: true)).each(&:small320!)
          end
        end
        set
      end
      .sort_by do |set|
        puts "Called #sets_from_user!"
        year, island = set.title.split(', ')
        year
      end
  end
end
