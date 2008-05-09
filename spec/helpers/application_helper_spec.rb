require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do

  it "应该可以按照预定方式显示时间" do
    show_time(Time.at(0)).should == "1970-01-01 08:00"
  end

  describe "应该可以解析出当前用户位置" do
    before(:each) do
      @forum = Forum.new(:id => 1, :name => '新闻')
      @topic = Topic.new(:forum => @forum)
      Forum.stub!(:find).with(1).and_return(@forum)
      Topic.stub!(:find).with(1).and_return(@topic)
      @forum.stub!(:id).and_return(1)
    end

    it "处理 /forums" do
      where_am_i('/forums').should == "论坛首页"
    end

    it "处理 /forums/1" do
      where_am_i('/forums/1').should == "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;新闻"
    end

    it "处理 /topics/1" do
      where_am_i('/topics/1').should == "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;<a href='/forums/1'>新闻</a>"
    end

    it "处理 /forums/1/topics/1" do
      where_am_i('/forums/1/topics/1').should == "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;<a href='/forums/1'>新闻</a>"
    end
  end
  
end
