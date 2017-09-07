# frozen_string_literal: true

require_relative './item'

# GildedRoseItem applise additional methods and modifiers in order to store
# methods which assist in interacting with Item
class GildedRoseItem < Item
  QUALITY_THRESHOLD = 50

  def aged?
    name.start_with?('Aged')
  end

  def age
    degrade_quality
    improve_quality
    reduce_sell_in
    expire
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

  def expired?
    sell_in.negative?
  end

  def expire
    return unless expired?
    @quality = 0 if backstage_pass?
    @quality += 1 if aged? && can_improve?
    @quality -= 1 if can_degrade?
  end

  def improve_quality
    return unless can_improve?
    @quality += improvement_level
    @quality = QUALITY_THRESHOLD if quality > QUALITY_THRESHOLD
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
