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

  def can_degrade?
    quality.positive? && !legendary? && !aged? && !backstage_pass?
  end

  def degrade_quality
    @quality -= 1 if can_degrade?
  end

  def legendary?
    name == 'Sulfuras, Hand of Ragnaros'
  end
end
