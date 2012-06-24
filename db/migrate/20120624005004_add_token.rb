class AddToken < ActiveRecord::Migration
  def change
  	add_column :stories, :token, :string
  end
end
