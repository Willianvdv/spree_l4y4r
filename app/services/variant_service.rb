class VariantService
  def initialize variant
    @variant = variant
  end

  def push_to_layer
    layer_client = client.post 'items', {}
    @variant.layer_id = layer_client['id']
    @variant.save!
  end

  private 

  def client
    @_client ||= LayerClient.new
  end
end