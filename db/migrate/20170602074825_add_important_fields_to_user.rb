class AddImportantFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :datetime
  end
end
