Spree::ProductsController.class_eval do
  after_action :push_show_event_to_layer, only: [:show]

  private

  def variant_service
    VariantService.push_to_layer @product, @user, 'view'
  end

  def push_show_event_to_layer
    variant_service.push_to_layer if spree_current_user
  end
end