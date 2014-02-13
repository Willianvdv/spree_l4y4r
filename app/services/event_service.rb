class EventService < BaseService
  def initialize(variant, user, type)
    @variant = variant
    @user = user
    @type = type
  end

  def push_to_layer
    event_data = { user_id: user_layer_id,
                   item_id: variant_layer_id }
    client.post 'events', event_data
  end

  def user_layer_id
    UserService.new(@user).layer_id
  end

  def variant_layer_id
    VariantService.new(@product).layer_id
  end
end