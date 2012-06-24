class Switchsccolumn < ActiveRecord::Migration
  def change
  	remove_column :stories, :sc_id
  	remove_column :stories, :thumbnail_file_name
  	remove_column :stories, :thumbnail_content_type
  	remove_column :stories, :thumbnail_file_size
  	remove_column :stories, :thumbnail_updated_at
  	add_column :stories, :has_audio, :boolean
  	add_column :stories, :has_thumbnail, :boolean
  end
end
