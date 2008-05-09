class AddCounters < ActiveRecord::Migration
  def self.up
    add_column :forums, :topics_count, :integer, :default=>0
    add_column :forums, :replies_count, :integer, :default=>0
    add_column :topics, :replies_count, :integer, :default=>0
  end

  def self.down
   remove_column :topics, :replies_count
   remove_column :forums, :replies_count
   remove_column :forums, :topics_count
  end
end
