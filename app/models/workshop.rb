class Workshop
  include ActiveAttr::Model

  attribute :name
  attribute :description

  def title
    name.gsub("-", " ").capitalize
  end

  def to_param
    name
  end

  def to_s
    title
  end

  def regular?
    type == "regular"
  end

  def extra?
    type == "extra"
  end

  def type
    if name.in? %w[painting caxixi archery]
      "extra"
    else
      "regular"
    end
  end

  def self.all
    Dir["#{Rails.root}/app/views/workshops/*.md"].map do |filename|
      name = File.basename(filename).chomp(".md")
      find(name)
    end
  end

  def self.find(name)
    new \
      name: name,
      description: File.read("#{Rails.root}/app/views/workshops/#{name}.md")
  end
end
