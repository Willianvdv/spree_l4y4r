require 'spec_helper'

describe VariantService do
  let(:variant) { create :variant }
  let(:client) { double }
  let(:magical_layer_id) { '12345678-1234-5678-1234-567812345678' }  #uuid 
  let(:item_json) { { 'id' => magical_layer_id } }

  subject { VariantService.new variant }  

  before do
    subject.stub(:client).and_return(client)
  end

  describe '.layer_id' do
    context 'isnt pushed to layer' do
      before do
        variant.layer_id = nil
      end

      it 'pushes data to layer if layer_id isnt set' do 
        subject.stub(:push_to_layer)
        expect(subject).to receive(:push_to_layer).once
        subject.layer_id
      end
    end

    context 'is already pushed to layer' do
      before do
        variant.layer_id = 1
      end

      it 'returns the layer id' do
        expect(subject.layer_id).to eq(variant.layer_id)
      end
    end
  end

  describe '.push_to_layer' do
    it 'client receives variant with arguments' do
      variant_params = {}
      client.should_receive(:post).with("items", variant_params).and_return(item_json)
      subject.push_to_layer
    end

    it 'stores layers item id to variant' do
      client.stub(:post).and_return(item_json)
      subject.push_to_layer
      expect(variant.layer_id).to eq(magical_layer_id)
    end
  end
end