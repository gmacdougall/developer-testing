# frozen_string_literal: true

# GildedRoseItem applise additional methods and modifiers in order to store
# methods which assist in interacting with Item
class GildedRoseItem < Item
  QUALITY_THRESHOLD = 50

  def aged?
    name.start_with?('Aged')
  end

  def backstage_pass?
    name.start_with?('Backstage pass')
  end

  def can_degrade?
    quality.positive? && !legendary? && !aged? && !backstage_pass?
  end

  def can_improve?
    quality < QUALITY_THRESHOLD && (aged? || backstage_pass?)
  end

  def degrade_quality
    @quality -= 1 if can_degrade?
  end

  def improve_quality
    return unless can_improve?
    @quality += improvement_level
    @quality = 50 if quality > 50
  end

  def legendary?
    name == 'Sulfuras, Hand of Ragnaros'
  end

  def reduce_sell_in
    @sell_in -= 1 unless legendary?
  end

  private

  def improvement_level
    if backstage_pass? && sell_in < 6
      3
    elsif backstage_pass? && sell_in < 11
      2
    else
      1
    end
  end
end
