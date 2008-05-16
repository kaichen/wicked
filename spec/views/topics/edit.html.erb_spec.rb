require File.dirname(__FILE__) + '/../../spec_helper'

describe "/topics/edit.html.erb" do
  include TopicsHelper
  
  before do
    @topic = mock_model(Topic, :id => 1, :title => 'test', 
                        :body => 'bodybodybodybodybody') 
    @topic.stub!(:forum_id)
    @topic.stub!(:forum).and_return(Forum.new)
    @topic.should_receive(:sticky).and_return(true)
    assigns[:topic] = @topic
  end

  it "should render edit form" do
    render "/topics/edit.html.erb"
    response.should have_tag("form[action=#{topic_path(@topic)}][method=post]") do
      with_tag('input#topic_title[name=?]', "topic[title]")
      with_tag('textarea#topic_body[name=?]', "topic[body]")
    end
  end
end


