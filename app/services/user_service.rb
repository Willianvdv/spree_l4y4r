class UserService
  def initialize user
    @user = user
  end

  def push_to_layer
    layer_client = client.post 'users', { identifier: @user.email }
    @user.layer_id = layer_client['id']
    @user.save!
  end

  private 

  def client
    @_client ||= LayerClient.new
  end
end