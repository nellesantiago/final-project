class RemoveUserIdAndPriceToPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :user_id
    remove_column :posts, :price
  end
end
