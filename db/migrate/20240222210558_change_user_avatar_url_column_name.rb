class ChangeUserAvatarUrlColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :photo_url, :def_avatar_url
  end
end
