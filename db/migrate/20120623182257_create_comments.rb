class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.references :user
    	t.references :story
    	t.text :content
      t.timestamps
    end
  end
end
