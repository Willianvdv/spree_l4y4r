class UserService < BaseService
  def initialize user
    @user = user
  end

  def layer_id
    push_to_layer if @user.layer_id.nil?
    @user.layer_id
  end

  def push_to_layer
    layer_client = client.post 'users', { identifier: @user.email }
    @user.layer_id = layer_client['id']
    @user.save!
  end
end