# encoding: utf-8

module PagesHelper
  def workshops
    %w[Yoga Painting Circus Singing]
  end

  def workshop_description(workshop)
    eval(workshop.upcase)
  end

  private

  YOGA = <<-YOGA.strip_heredoc.freeze
    # Yoga

    ![Lidija doing yoga](/assets/workshops/yoga.jpg)

    Practicing yoga means meeting your own self -- feeling your own body, becoming aware of your thoughts, allowing your emotions to emerge, experiencing your inner energy and encouraging your creativity.

    The yoga lessons are held in the morning in the open, so that we can feel the nature and the peace of the island. The lesson consists of body postures (*asanas*), breathing techniques (*pranayama*), relaxation and meditation. The body becomes more flexible, we awaken our energy and reach the state of inner peace and love. We feel excellent and wish to share it with the others.

    The workshop is conducted by Lidija Georgieva, who is the owner and manager of her Yoga centre in Skopje, Macedonia ([www.yogacenter.com.mk](http://www.yogacenter.com.mk)).
  YOGA

  PAINTING = <<-PAINTING.strip_heredoc.freeze
    # Painting

    ![[Peter painting]](/assets/workshops/painting.jpg)

    Painting workshops are held twice a day---once for younger children and once for older children and adults. Attendants will have the oportunity to paint with primary and secondary acrylic colors on a canvas and to continuously develop their paintings. The motif can emerge spontaneously (from the color itself) or it can be predetermined, it depends solely on personal preference.

    Even though we will supply painting easels, palletes, colors and different canvas formats, attendants can also bring their own equipment for other artistic techniques. We will observe the paintings each day to help attendants develop new possibilities for their paintings. After the first week attendants should come up with a general idea about the style, motif and feel of their paintings. During the last few days, they can submit their paintings to the gallery for everyone to enjoy.
  PAINTING

  CIRCUS = <<-CIRCUS.strip_heredoc.freeze
    # Circus

    ![[Željko & Melani on the silk]](/assets/workshops/circus.jpg)

    Circus workshops are held twice a day---once for smaller children and once for older children and adults. Circus is a workshop which includes a great variety of activities, like juggling, balances, acrobatics, clowning, parkour, diabolo, poi, silk and pretty much everything else that comes to your mind!

    During the first half of the workshop, attendants will be introduced with all the possibilities offered to them. Through games and other activities they will be able to learn new things or practice what they already know. During the second half of the workshop, attendants will start preparing for the big performance at the end of the workshop.

    The goal of the workshop is developing creativity, discovering new talents and to have as much fun as possible!
  CIRCUS

  SINGING = <<-SINGING.strip_heredoc.freeze
    # Singing

    ![Hana and Nino](/assets/workshops/singing.jpg)

    During Waldorf Camps 2010 and 2011 Hana Mačkovšek Šloser and Nino Šloser held workshops of West African songs and rhytms. Their main aim was to teach a few of many West African songs and rhytms with help of sounds of our bodies (body percussion method), with simple natural instruments (like stones), through singing and vocalizing them and, of course, with dancing and playing on typical West African percussion instruments -- djembe and dunun. These were cross- generational workshops, suitable for children, their parents and grandparents and great chance for all these generations to be active together through music. 

    Mentors Hana Mačkovšek Šloser and Nino Šloser are music teachers from Slovenia, who both graduated on the topic of West African rhytms and percussions and are both active in field of multicultural musical education.
  SINGING
end
