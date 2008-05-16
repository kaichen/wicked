require File.dirname(__FILE__) + '/../../spec_helper'

describe "/topics/new.html.erb" do
  include TopicsHelper
  
  before(:each) do
    @topic = mock_model(Topic, 
				:title => 'test', 
				:body => 'bodybodybodybodybody',
				:forum_id => 1)
    @topic.stub!(:new_record?).and_return(true)
    @topic.stub!(:title).and_return("MyString")
    @topic.stub!(:body).and_return("MyText")
    @topic.stub!(:forum).and_return(Forum.new)
    @topic.stub!(:sticky).and_return(true)
    assigns[:topic] = @topic
  end

  it "should render new form" do
    render "/topics/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", topics_path) do
      with_tag("input#topic_title[name=?]", "topic[title]")
	with_tag("input#topic_forum_id[name=?]", "topic[forum_id]")
      with_tag("textarea#topic_body[name=?]", "topic[body]")
    end
  end
end


