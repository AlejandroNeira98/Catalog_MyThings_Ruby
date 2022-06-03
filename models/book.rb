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
    publish_date, archived, publisher = hash.values_at('publish_date', 'archived', 'publisher')
    cover_state, id, label_id = hash.values_at('cover_state', 'id', 'label_id')
    new_instance = new(publish_date, archived, publisher, cover_state, id: id)
    found_label = labels.find { |label| label.id == label_id }
    found_label&.add_item(new_instance)
    new_instance
  end
end
