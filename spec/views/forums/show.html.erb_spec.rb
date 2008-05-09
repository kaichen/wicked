require File.dirname(__FILE__) + '/../../spec_helper'

describe "/forums/show.html.erb视图模板" do
  include ForumsHelper
  
  before(:each) do
    @forum = mock_model(Forum, :id => 1, 
                          :name => 'Test', 
                          :description => 'test version', 
                          :topics_count => 3, 
                          :replies_count => 3)
    @topic = mock_model(Topic, :id => 1, 
                               :title => 'test', 
                               :replies => [mock_model(Reply)],
                               :created_at => Time.now)
    @topic.replies.stub!(:count)
    @topic.stub!(:hits)
    @topic.stub!(:last_post_time).and_return(Time.now)
    assigns[:forum] = @forum
    assigns[:topics] = [@topic]
  end

  it "应该渲染对应模板" do
    render "/forums/show.html.erb"
  end

  it "应该生成子论坛名称" do
    render "/forums/show.html.erb"
    response.should have_tag('h2', @forum.name)
  end

  it "应该生成帖子表格" do
    render "/forums/show.html.erb"
    response.should have_tag('table')
  end
end

