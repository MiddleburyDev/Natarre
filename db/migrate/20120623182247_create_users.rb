class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :email
    	t.string :password
    	t.integer :fb_id
    	t.string :fb_token
    	t.integer :twitter_id
    	t.string :twitter_token
    	
      t.timestamps
    end
  end
end
