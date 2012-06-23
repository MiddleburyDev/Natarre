class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
    	t.text :question
      t.timestamps
    end
  end
end
