class Item
  def initialize(genre, author, source, label, date, archived, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = date
    @archived = archived
  end
end