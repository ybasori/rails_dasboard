class CreateRoleModulepage < ActiveRecord::Migration[5.1]
  def change
    create_table :modulepages_roles, id:false do |t|
      t.belongs_to :role, index: true
      t.belongs_to :modulepage, index: true
    end
  end
end
