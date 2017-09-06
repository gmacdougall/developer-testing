# frozen_string_literal: true

# GildedRoseItem applise additional methods and modifiers in order to store
# methods which assist in interacting with Item
class GildedRoseItem < Item
  def legendary?
    name == 'Sulfuras, Hand of Ragnaros'
  end
end
