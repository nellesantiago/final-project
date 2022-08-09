class AddScopeToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :scope, :integer, default: 0
  end
end
