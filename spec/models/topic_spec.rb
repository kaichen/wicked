require File.dirname(__FILE__) + '/../spec_helper'

describe Topic do
  before(:each) do
    @topic = create_topic
  end
  
  def create_topic (options={:title => 'default', :body => 'testingtestingtesingtesting'})
    Topic.new(options)
  end

  it "should be valid" do
    topic = Topic.new
    topic.should_not be_valid
    topic.errors.invalid?(:title)
    topic.errors.invalid?(:body)
    
    topic.errors_on(:title).should eql ["can't be blank"]
    topic.errors_on(:body).should eql  ["can't be blank", "is too short (minimum is 16 characters)"]
  end


  it "should know the count of hits" do
     @topic.hits.should eql 0
     @topic.hit!
  end

  it "should know the sum of replies" do
    @topic.save
    @topic.replies.count.should eql 0
    lambda {
      do_reply(@topic).save
    }.should change {@topic.replies.count}
    @topic.replies.count.should eql 1
  end
  
  it "should know the last post" do
    @topic.save
    @topic.last_post.should == @topic
    reply = @topic.replies.create(:body => 'testingtestingtesting', :created_at => Time.now + 10.seconds)
    reply.topic.should === @topic
    @topic.last_post.should == reply
    reply = @topic.replies.create(:body => 'testingtestingtesting', :created_at => Time.now + 20.seconds)
    @topic.last_post.should == reply
  end
  
 
  
  it "should sort in order" do
    t1 = Topic.new(:title => 't1', :body => 'testingtesingtesting')
    t1.save
    t2 = Topic.new(:title => 't2', :body => 'testingtesingtesting')
    t2.save
    t2.update_attributes(:created_at => (t1.created_at + 5.seconds))
    Topic.find(:all).sort_by{|x| x.last_post.created_at}.last.should === t2
    t1.replies.create(:body => 'tesingtsingsjdksldk', :created_at => t1.created_at + 10.seconds)
    Topic.find(:all).sort_by{|x| x.last_post.created_at}.last.should === t1
  end
  
  def do_reply(topic, options = {})
    options.merge!({:body => 'testingtesingtesting'})
    topic.do_reply(options)
  end
end
