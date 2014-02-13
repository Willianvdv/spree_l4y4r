class VariantService < BaseService
  def initialize variant
    @variant = variant
  end

  def layer_id
    push_to_layer if @variant.layer_id.nil?
    @variant.layer_id
  end

  def push_to_layer
    layer_client = client.post 'items', {}
    @variant.layer_id = layer_client['id']
    @variant.save!
  end
end