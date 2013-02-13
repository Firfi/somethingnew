class AddPasswordConfirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_confirm_token, :string
  end
end
