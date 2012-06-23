class AddSoundcloud < ActiveRecord::Migration
  def change
  	add_column :stories, :sc_id, :integer 
  end
end
