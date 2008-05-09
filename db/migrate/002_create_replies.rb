class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.string :title
      t.text :body
      t.integer :topic_id


      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
