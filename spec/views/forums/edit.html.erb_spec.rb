require File.dirname(__FILE__) + '/../../spec_helper'

describe "/forums/edit.html.erb模板" do
  include ForumsHelper
  
  before do
    @forum = mock_model(Forum, :id => 1, 
                          :name => 'Test', 
                          :description => 'test version', 
                          :topics_count => 3, 
                          :replies_count => 3)
    assigns[:forum] = @forum
  end

  it "应该渲染 edit 表单" do
    render "/forums/edit.html.erb"
    response.should have_tag("form[action=#{forum_path(@forum)}][method=post]") do
    end
  end
end


