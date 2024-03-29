class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.string :body, limit: 100, null: false

      t.timestamps
    end
  end
end
