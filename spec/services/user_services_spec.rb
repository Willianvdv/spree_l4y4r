require 'spec_helper'

describe UserService do
  let(:user) { create :user }
  let(:client) { double }

  subject { UserService.new user }  

  before do
    subject.stub(:client).and_return(client)
  end

  describe 'push data to layer' do
    it 'client receives user with arguments' do
      user_params = { identifier: user.email }
      client.should_receive(:post).with("users", user_params)
      subject.push
    end
  end
end