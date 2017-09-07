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
      if item.name != 'Aged Brie' &&
         item.name != 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality.positive?
          item.quality = item.quality - 1 unless item.legendary?
        end
      elsif item.quality < 50
        item.quality = item.quality + 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11 && item.quality < 50
            item.quality = item.quality + 1
          end
          if item.sell_in < 6 && item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
      item.sell_in = item.sell_in - 1 unless item.legendary?
      next unless item.sell_in.negative?
      if item.name != 'Aged Brie'
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality.positive?
            item.quality = item.quality - 1 unless item.legendary?
          end
        else
          item.quality = item.quality - item.quality
        end
      elsif item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end
end
