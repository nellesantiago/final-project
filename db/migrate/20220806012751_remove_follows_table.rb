class RemoveFollowsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :follows
  end
end
