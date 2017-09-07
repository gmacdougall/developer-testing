# frozen_string_literal: true

# Gilded Rose will define the quality for a large set of items based upon the
# attributes of an item.
class GildedRose
  attr_reader :items

  def initialize(item_attributes)
    @items = item_attributes.map { |args| GildedRoseItem.new(*args) }
  end

  def update_quality
    @items.each do |item|
      item.degrade_quality
      item.improve_quality
      item.reduce_sell_in
      item.expire
    end
  end
end
