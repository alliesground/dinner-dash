class AddStatusToOrders < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE order_status AS ENUM ('ordered', 'paid', 'cancelled', 'completed');
    SQL
    add_column :orders, :status, :order_status
    add_index :orders, :status
  end

  def down
    remove_column :orders, :status
    execute <<-SQL
      DROP TYPE order_status;
    SQL
  end
end
