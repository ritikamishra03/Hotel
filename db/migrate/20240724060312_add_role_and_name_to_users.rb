# frozen_string_literal: true

class AddRoleAndNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
  end
end
