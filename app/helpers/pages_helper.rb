# encoding: utf-8

module PagesHelper
  def workshops
    %w[Yoga Painting Circus Singing]
  end

  def workshop_description(workshop)
    File.read("#{Rails.root}/app/views/pages/workshops/#{workshop}.md")
  end
end
