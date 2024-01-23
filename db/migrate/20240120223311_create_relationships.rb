class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :followed_by, null: false, foreign_key: {to_table: :users}
      t.references :following, null: false, foreign_key: {to_table: :users}
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
