require File.dirname(__FILE__) + '/../../spec_helper'

describe "/site/index.html.erb" do
  include SiteHelper

  before(:each) do
    assigns[:recent_topics] = [Topic.new(:created_at => Time.now)]
    assigns[:hot_topics] = [Topic.new(:hits => 5)]
    render '/site/index.html.erb'
  end

  it '应该可以渲染两个<ol>' do
    response.should have_tag('ol.topics', :count => 2)
  end

end
