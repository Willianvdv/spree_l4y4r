class AddLayerIdToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :layer_id, :string
  end
end
