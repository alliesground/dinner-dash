class AddActiveForSaleToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :active_for_sale, :bool, default: true
  end
end
