require File.dirname(__FILE__) + '/../../spec_helper'

describe "/forums/index.html.erb" do
  include ForumsHelper
  before(:each) do
    # Do nothin
    @forums = [mock_model(Forum, :id => 1, 
                          :name => 'Test', 
                          :description => 'test version', 
                          :topics_count => 3, 
                          :replies_count => 3)]
    assigns[:forums] = @forums
  end

  it "应该渲染/forums/index.html.erb模板" do
    render "/forums/index.html.erb"
  end

end

