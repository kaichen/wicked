class Forum < ActiveRecord::Base
  has_many :topics,:dependent => :destroy
  has_many :replies,:dependent => :destroy
end
