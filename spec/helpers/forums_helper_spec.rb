require File.dirname(__FILE__) + '/../spec_helper'

describe ForumsHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should include the ForumHelper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(ForumsHelper)
  end

  it "应该可以知道全部文章的数量" do
    @forum = mock_model(Forum, :topics => [@topic])
    @topic = mock_model(Topic)
    @topics.stub!(:replies_count).and_return(1)
    total_replies(@forum).should == 2
  end
  
end
