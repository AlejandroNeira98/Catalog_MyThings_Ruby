require './item'
class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, archived, publisher, cover_state, id: nil)
    super(publish_date, archived, id: id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || (@cover_state == 'bad')
  end

  def to_json(*_args)
    { publish_date: @publish_date, archived: @archived, publisher: @publisher, cover_state: @cover_state, id: @id,
      label_id: @label.id }.to_json
  end

  def self.from_hash(hash, labels)
    publish_date, archived, publisher, cover_state, id = *hash
    new_instance = new(publish_date, archived, publisher, cover_state, id: id)
    found_label = labels.find { |label| label.id == id }
    found_label&.add_item(label)

    new_instance
  end
end
