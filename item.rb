# frozen_string_literal: true

class Item
  attr_accessor :author, :genre, :source, :label

  def initialize(date, archived, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @publish_date = date
    @archived = archived
  end

  def add_author(author)
    @author = author
  end

  def add_genre(genre)
    @genre = genre
  end

  def add_source(source)
    @source = source
  end

  def add_label(label)
    @label = label
  end

  def can_be_archived?
  
  end

  def move_to_archived

  end
end
