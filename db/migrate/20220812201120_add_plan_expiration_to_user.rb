class AddPlanExpirationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :plan_expiration, :datetime
  end
end
