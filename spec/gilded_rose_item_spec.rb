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

  describe '#can_improve?' do
    subject { item.can_improve? }

    context 'when the item is aged' do
      let(:name) { 'Aged Brie' }
      it { should be true }

      context 'when the quality is 50 or greater' do
        let(:quality) { 50 }
        it { should be false }
      end
    end

    context 'when the item is a backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
      it { should be true }

      context 'when the quality is 50 or greater' do
        let(:quality) { 50 }
        it { should be false }
      end
    end

    context 'when the item is regular' do
      it { should be false }
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

  describe 'expire' do
    subject { item.expire }
    let(:sell_in) { -1 }

    context 'when the item is a backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      context 'when the sell in is negative' do
        it 'reduces quality to zero' do
          expect { subject }.to change { item.quality }.to(0)
        end
      end

      context 'when the sell in is not negative' do
        let(:sell_in) { 0 }
        it { expect { subject }.to_not change { item.quality } }
      end
    end

    context 'when the item is aged' do
      let(:name) { 'Aged Brie' }

      context 'when the quality is less than 50' do
        it { expect { subject }.to change { item.quality }.by(1) }
      end

      context 'when the quality is 50' do
        let(:quality) { 50 }
        it { expect { subject }.to_not change { item.quality } }
      end
    end

    context 'when the item is regular' do
      it { expect { subject }.to change { item.quality }.by(-1) }
    end
  end

  describe '#expired?' do
    subject { item.expired? }

    context 'when the sell_in is negative' do
      let(:sell_in) { -1 }
      it { should be true }
    end

    context 'when the sell_in is 0 or positive' do
      let(:sell_in) { 0 }
      it { should be false }
    end
  end

  describe '#improve_quality' do
    subject { item.improve_quality }
    let(:name) { 'Aged Brie' }
    let(:quality) { 49 }

    it 'improves the quality by 1' do
      expect { subject }.to change { item.quality }.from(49).to(50)
    end

    context 'when the quality is already 50' do
      let(:quality) { 50 }

      it 'does not change the quality of the item' do
        expect { subject }.to_not change { item.quality }
      end
    end

    context 'when the item is a backstage pass' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
      let(:quality) { 10 }

      context 'when the sell in is 11' do
        let(:sell_in) { 11 }

        it 'improves quality by 1' do
          expect { subject }.to change { item.quality }.by(1)
        end
      end

      context 'when the sell in is 10' do
        let(:sell_in) { 10 }

        it 'improves quality by 2' do
          expect { subject }.to change { item.quality }.by(2)
        end
      end

      context 'when the sell in is 5' do
        let(:sell_in) { 5 }

        it 'improves quality by 3' do
          expect { subject }.to change { item.quality }.by(3)
        end
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

  describe '#reduce_sell_in' do
    subject { item.reduce_sell_in }

    context 'when the item is legendary' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it 'does not reduces sell in' do
        expect { subject }.to_not change { item.sell_in }
      end
    end

    context 'when the item is a standard item' do
      it 'reduces sell in by 1' do
        expect { subject }.to change { item.sell_in }.by(-1)
      end
    end
  end
end
