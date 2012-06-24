class ChangeViews < ActiveRecord::Migration
  def change
  	remove_column :stories, :views
  	add_column :stories, :views, :integer, :default => 0
  end
end
