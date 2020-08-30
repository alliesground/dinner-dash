class AddDefaultForNotNullColumnsInItems < ActiveRecord::Migration[6.0]
  def change
    change_column_default :items, :title, ""
    change_column_default :items, :desc, ""
  end
end
