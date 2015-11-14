require 'spec_helper'

describe Workable::Collection do
  describe 'delegation' do
    let(:collection){ described_class.new(
      data: [1, 2, 3],
      next_page_method: double,
      transform_mapping: :job,
      root_key: 'jobs')
    }

    it 'delegates size to `data`' do
      expect(collection.size).to eq(3)
    end

    it 'delegates each to `data`' do
      expect(collection.each).to be_kind_of(Enumerator)
    end

    it 'delegates [] to `data`' do
      expect(collection[1]).to eq(2)
    end

    it 'delegates .first to `data`' do
      expect(collection.first).to eq (1)
    end

    it 'delegates map to `data`' do
      expect(collection.map { |q| q*2 }).to eq([2, 4, 6])
    end
  end

  describe '#fetch_next_page' do
    let(:next_method){ double }
    let(:collection){ described_class.new(
      data: [],
      next_page_method: next_method,
      transform_mapping: :job,
      root_key: 'jobs',
      paging: paging)
    }

    context 'when next page is available' do
      let(:paging){ { 'next' => 'http://example.com?limit=2&since_id=3' } }

      it 'executes next_method with next page url' do
        expect(next_method).to receive(:call).with('http://example.com?limit=2&since_id=3', :job, 'jobs')
        collection.fetch_next_page
      end
    end

    context 'when next page is not available' do
      let(:paging){ nil }

      it 'does nothing' do
        expect(collection.fetch_next_page).to be_nil
      end
    end
  end
end
