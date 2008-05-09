class AddHits < ActiveRecord::Migration
  def self.up
    add_column :topics,:hits,:integer,:default => 0
  end

  def self.down
    remove_column :topics,:hits
  end
end
