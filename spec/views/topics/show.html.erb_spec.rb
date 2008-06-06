require File.dirname(__FILE__) + '/../../spec_helper'

describe "/topics/show.html.erb" do
  include TopicsHelper
  
  before(:each) do
    @topic = stub_model(Topic, :title => "new topic", 
    :body => "new topic", 
    :created_at => Time.now)
    @replies = [stub_model(Reply, :title => 'test', :body => 'bodybodybody', :created_at => Time.now)]
    @replies.stub!(:total_pages).and_return(1)
    @topic.stub!(:forum).and_return(Forum.new)
    assigns[:topic] = @topic
    assigns[:replies] = @replies
  end

  it "should render attributes in <p>" do
    render "/topics/show.html.erb"
    response.should have_text(/new topic/)
    response.should have_text(/new topic/)
  end
end
