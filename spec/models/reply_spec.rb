require File.dirname(__FILE__) + '/../spec_helper'

describe Reply do
  before(:each) do
    @reply = Reply.new
  end

  it "should be valid" do
    @reply.should_not be_valid
    @reply.errors.invalid?(:body)
    @reply.errors_on(:body).should eql  ["is too short (minimum is 16 characters)"]
  end
  
end
