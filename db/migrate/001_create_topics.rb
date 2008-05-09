class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :title
      t.text :body
      t.integer :forum_id

      
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
