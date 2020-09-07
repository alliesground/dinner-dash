class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :item, null: false, foreign_key: true
    end
  end
end
