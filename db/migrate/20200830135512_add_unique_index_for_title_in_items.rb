class AddUniqueIndexForTitleInItems < ActiveRecord::Migration[6.0]
  def change
    add_index :items, :title, unique: true
  end
end
