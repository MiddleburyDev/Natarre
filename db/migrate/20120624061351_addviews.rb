class Addviews < ActiveRecord::Migration
  def change
  	add_column :stories, :views, :integer
  end
end
