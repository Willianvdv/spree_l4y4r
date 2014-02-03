require 'spec_helper'

describe UserService do
  let(:user) { create :user }
  let(:client) { double }

  subject { UserService.new user }  

  before do
    subject.stub(:client).and_return(client)
  end

  describe 'push data to l4y4r' do
    it 'posting data to the client' do
      user_params = { identifier: user.email }
      client.should_receive(:post).with("users", user_params)
      subject.push
    end
  end
end