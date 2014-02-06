require 'spec_helper'

describe UserService do
  let(:user) { create :user }
  let(:client) { double }
  let(:magical_layer_id) { '12345678-1234-5678-1234-567812345678' }  #uuid 
  let(:client_json) { { 'id' => magical_layer_id } }

  subject { UserService.new user }  

  before do
    subject.stub(:client).and_return(client)
  end

  describe 'push data to layer' do
    it 'client receives user with arguments' do
      user_params = { identifier: user.email }
      client.should_receive(:post).with("users", user_params).and_return(client_json)
      subject.push_to_layer
    end

    it 'stores layers user id to user' do
      client.stub(:post).and_return(client_json)
      subject.push_to_layer
      expect(user.layer_id).to eq(magical_layer_id)
    end
  end
end