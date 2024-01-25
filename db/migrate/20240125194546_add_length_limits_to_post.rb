class AddLengthLimitsToPost < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :body, :string, limit: 250
  end
end
