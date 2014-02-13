require 'spec_helper'

describe EventService do
  let(:variant) { create :variant }
  let(:user) { create :user }  
  let(:event_type) { 'view' }
  let(:client) { double }
  let(:magical_layer_id) { '12345678-1234-5678-1234-567812345678' }  #uuid 
  let(:event_json) { { 'id' => magical_layer_id } }
  let(:user_layer_id) { 0 }
  let(:variant_layer_id) { 0 }

  subject { EventService.new variant, 
                             user, 
                             event_type }

  before do
    subject.stub(:client).and_return(client)
    UserService.any_instance
               .stub(:layer_id)
               .and_return(user_layer_id)
    VariantService.any_instance
                  .stub(:layer_id)
                  .and_return(variant_layer_id)
  end

  describe '.push_to_layer' do
    it 'client receives events with arguments' do
      event_params = { user_id: user_layer_id,
                       item_id: variant_layer_id }

      client.should_receive(:post)
            .with("events", event_params)
            .and_return(event_json)

      subject.push_to_layer
    end
  end
end
