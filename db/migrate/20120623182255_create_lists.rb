class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
    	t.references :user
    	t.references :story
      t.timestamps
    end
  end
end
