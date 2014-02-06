class UserService
  def initialize user
    @user = user
  end

  def push
    layer_client = client.post 'users', { identifier: @user.email }
    @user.layer_id = layer_client['id']
    @user.save!
  end

  private 

  def client
    @_client ||= LayerClient.new
  end
end

class LayerClient
  def post topic, params
    RestClient.post "http://localhost/#{topic}", params.to_json, 
                                                 :content_type => :json, 
                                                 :accept => :json
  end
end