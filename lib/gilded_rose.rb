# frozen_string_literal: true

# Gilded Rose will define the quality for a large set of items based upon the
# attributes of an item.
class GildedRose
  attr_reader :items

  def initialize(item_attributes)
    @items = item_attributes.map { |args| Item.new(*args) }
  end

  def update_quality
    for i in 0..(@items.size - 1)
      if @items[i].name != 'Aged Brie' &&
         @items[i].name != 'Backstage passes to a TAFKAL80ETC concert'
        if @items[i].quality.positive?
          if @items[i].name != 'Sulfuras, Hand of Ragnaros'
            @items[i].quality = @items[i].quality - 1
          end
        end
      elsif @items[i].quality < 50
        @items[i].quality = @items[i].quality + 1
        if @items[i].name == 'Backstage passes to a TAFKAL80ETC concert'
          if @items[i].sell_in < 11 && @items[i].quality < 50
            @items[i].quality = @items[i].quality + 1
          end
          if @items[i].sell_in < 6 && @items[i].quality < 50
            @items[i].quality = @items[i].quality + 1
          end
        end
      end
      if @items[i].name != 'Sulfuras, Hand of Ragnaros'
        @items[i].sell_in = @items[i].sell_in - 1
      end
      next unless @items[i].sell_in.negative?
      if @items[i].name != 'Aged Brie'
        if @items[i].name != 'Backstage passes to a TAFKAL80ETC concert'
          if @items[i].quality > 0
            if @items[i].name != 'Sulfuras, Hand of Ragnaros'
              @items[i].quality = @items[i].quality - 1
            end
          end
        else
          @items[i].quality = @items[i].quality - @items[i].quality
        end
      elsif @items[i].quality < 50
        @items[i].quality = @items[i].quality + 1
      end
    end
  end
end
