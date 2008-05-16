class SiteController < ApplicationController

  def index
    @recent_topics = Topic.find(:all, :order => 'created_at DESC', :limit => 10)
    @hot_topics = Topic.find(:all, :order => 'hits DESC', :limit => 10)
  end
end
