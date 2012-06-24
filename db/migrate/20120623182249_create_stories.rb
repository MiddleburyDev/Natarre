class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
    	t.string :title
    	t.text :content
    	t.references :prompt
    	t.references :user
    	t.references :story
      t.timestamps
    end
  end
end
