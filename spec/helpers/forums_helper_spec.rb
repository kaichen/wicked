require File.dirname(__FILE__) + '/../spec_helper'

describe ForumsHelper do
  
  it "应该可以知道全部文章的数量" do
    @forum = mock_model(Forum, :topics => [@topic])
    @topic = mock_model(Topic)
    @topics.stub!(:replies_count).and_return(1)
    total_replies(@forum).should == 2
  end
  
end
