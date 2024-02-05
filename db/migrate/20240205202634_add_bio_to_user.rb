class AddBioToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string, default: nil, limit: 100
  end
end
