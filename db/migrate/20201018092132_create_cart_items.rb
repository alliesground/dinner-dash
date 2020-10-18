class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
    end
  end
end
