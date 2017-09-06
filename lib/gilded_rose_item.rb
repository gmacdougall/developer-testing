# frozen_string_literal: true

# GildedRoseItem applise additional methods and modifiers in order to store
# methods which assist in interacting with Item
class GildedRoseItem < Item
  def aged?
    name.start_with?('Aged')
  end

  def backstage_pass?
    name.start_with?('Backstage pass')
  end

  def legendary?
    name == 'Sulfuras, Hand of Ragnaros'
  end
end
