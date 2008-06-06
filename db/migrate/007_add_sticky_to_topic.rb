class AddStickyToTopic < ActiveRecord::Migration
  def self.up
    add_column "topics","sticky",:integer,:defalut => 0
  end

  def self.down
    remove_column "topics", "sticky"
  end
end
