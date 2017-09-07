# frozen_string_literal: true

require 'rspec'

require_relative '../lib/gilded_rose_item'

RSpec.describe GildedRoseItem do
  let(:item) { described_class.new(name, sell_in, quality) }

  let(:name) { 'Name' }
  let(:sell_in) { 1 }
  let(:quality) { 1 }

  describe '#aged?' do
    subject { item.aged? }

    context 'when the item is Aged Brie' do
      let(:name) { 'Aged Brie' }
      it { should be true }
    end

    context 'when the item is a standard item' do
      it { should be false }
    end
  end

  describe '#backstage_pass?' do
    subject { item.backstage_pass? }

    context 'when the item is Backstage passes to a TAFKAL80ETC concert' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
      it { should be true }
    end

    context 'when the item is a standard item' do
      it { should be false }
    end
  end

  describe '#can_degrade?' do
    subject { item.can_degrade? }

    context 'when the item is legendary' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }
      it { should be false }
    end

    context 'when the item is aged' do
      let(:name) { 'Aged Brie' }
      it { should be false }
    end

    context 'when the item is a backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
      it { should be false }
    end

    context 'when the item is regular' do
      it { should be true }
    end
  end

  describe '#degrade_quality' do
    subject { item.degrade_quality }

    it 'reduces the quality by 1' do
      expect { subject }.to change { item.quality }.from(1).to(0)
    end

    context 'when the item does not degrade' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it 'does not reduce the quality' do
        expect { subject }.to_not change { item.quality }
      end
    end
  end

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
