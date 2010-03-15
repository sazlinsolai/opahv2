class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.column :user_id, :integer
      t.column :role_id, :integer
      t.column :created_at, :datetime
    end

    add_index :user_roles, [:user_id, :role_id], :unique => true
    add_index :roles, :name
  end

  def self.down
    drop_table :user_roles
  end
end
