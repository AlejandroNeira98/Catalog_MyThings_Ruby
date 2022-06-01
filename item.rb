class Item
  attr_accessor :author, :genre, :source, :label, :archived, :publish_date

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
    current_time = Time.new
    return true if (current_time.year - @publish_date.year) >= 10

    false
  end

  def move_to_archived
    @archived = true if can_be_archived?
  end
end
