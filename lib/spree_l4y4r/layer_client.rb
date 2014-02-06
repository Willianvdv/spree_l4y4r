class LayerClient
  def post topic, params
    RestClient.post "http://localhost/#{topic}", params.to_json, 
                                                 :content_type => :json, 
                                                 :accept => :json
  end
end