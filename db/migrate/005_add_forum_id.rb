class AddForumId < ActiveRecord::Migration
  def self.up
   add_column :replies,:forum_id,:integer
  end

  def self.down
   remove_column :replies,:forum_id
  end
end
