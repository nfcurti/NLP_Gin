class AddSubidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subid, :string
  end
end
