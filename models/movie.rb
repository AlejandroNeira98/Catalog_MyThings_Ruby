require_relative '../item'
require 'json'

class Movie < Item
  attr_accessor :silent

  def initialize(publish_date, archived, silent, id: nil)
    super(publish_date, archived, id: id)
    @silent = silent
  end

  def can_be_archived?
    super || (@silent == true)
  end

  def as_json()
    {
      JSON.create_id => self.class.name,
      'a' => [@publish_date, @archived, @silent, @id,
              { source_id: @source.id, genre_id: @genre.id, label_id: @label.id }]
    }
  end

  def to_json(*options)
    as_json.to_json(*options)
  end

  def self.json_creates(object, labels, sources, genres)
    publish_date, archived, silent, id, ids = object['a']
    new_instance = new(publish_date, archived, silent, id: id)
    found_label = labels.find { |label| label.id == ids['label_id'] }
    found_label&.add_item(new_instance)
    found_source = sources.find { |source| source.id == ids['source_id'] }
    found_source&.add_item(new_instance)
    found_genre = genres.find { |genre| genre.id == ids['genre_id'] }
    found_genre&.add_item(new_instance)
    new_instance
  end
end
