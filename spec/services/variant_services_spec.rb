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

  describe 'push data to layer' do
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