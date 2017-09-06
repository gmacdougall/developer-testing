# frozen_string_literal: true

require 'rspec'

require_relative '../lib/gilded_rose_item'

RSpec.describe GildedRoseItem do
  let(:item) { described_class.new(name, sell_in, quality) }

  let(:name) { 'Name' }
  let(:sell_in) { 1 }
  let(:quality) { 1 }

  describe '#legendary?' do
    subject { item.legendary? }

    context 'when the item is Sulfuras, Hand of Ragnaros' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it { should be true }
    end

    context 'when the item is a standard item' do
      it { should be false }
    end
  end
end
