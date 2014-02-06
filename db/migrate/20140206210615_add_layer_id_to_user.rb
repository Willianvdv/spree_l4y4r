class AddLayerIdToUser < ActiveRecord::Migration
  def change
    add_column Spree.user_class.table_name.to_sym, :layer_id, :string
  end
end
