require 'spec_helper'

describe UserService do
  let(:user) { create :user }
  let(:client) { double }
  let(:magical_layer_id) { '12345678-1234-5678-1234-567812345678' }  #uuid 
  let(:user_json) { { 'id' => magical_layer_id } }

  subject { UserService.new user }  

  before do
    subject.stub(:client).and_return(client)
  end

  describe '.layer_id' do
    context 'isnt pushed to layer' do
      before do
        user.layer_id = nil
      end

      it 'pushes data to layer if layer_id isnt set' do 
        subject.stub(:push_to_layer)
        expect(subject).to receive(:push_to_layer).once
        subject.layer_id
      end
    end

    context 'is already pushed to layer' do
      before do
        user.layer_id = 1
      end

      it 'returns the layer id' do
        expect(subject.layer_id).to eq(user.layer_id)
      end
    end
  end

  describe 'push data to layer' do
    it 'client receives user with arguments' do
      user_params = { identifier: user.email }
      client.should_receive(:post).with("users", user_params).and_return(user_json)
      subject.push_to_layer
    end

    it 'stores layers user id to user' do
      client.stub(:post).and_return(user_json)
      subject.push_to_layer
      expect(user.layer_id).to eq(magical_layer_id)
    end
  end
end