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
      'a' => [@publish_date, @archived, @silent, @id]
    }
  end

  def to_json(*options)
    as_json.to_json(*options)
  end

  def self.json_creates(object)
    publish_date, archived, silent, id = object['a']
    new(publish_date, archived, silent, id: id)
  end
end
