require File.dirname(__FILE__) + '/../spec_helper'

describe RepliesController do
  describe "路由生成" do
  
    it "应该可以映射 { :controller => 'replies', :action => 'new', :topic_id => 1 } 到 /topics/1/replies/new" do
      route_for(:controller => "replies", :action => "new", :topic_id => 1).should == "/topics/1/replies/new"
    end
  
    it "应该可以映射 { :controller => 'replies', :action => 'edit', :topic_id => 1, :id => 1 } 到 /topics/1/replies/1/edit" do
      route_for(:controller => "replies", :action => "edit", :topic_id => 1, :id => 1).should == "/topics/1/replies/1/edit"
    end
  
    it "应该可以映射 { :controller => 'replies', :action => 'update', :topic_id => 1, :id => 1} 到 /topics/1/replies/1" do
      route_for(:controller => "replies", :action => "update", :topic_id => 1, :id => 1).should == "/topics/1/replies/1"
    end
  
    it "应该可以映射 { :controller => 'replies', :action => 'destroy', :topic_id => 1, :id => 1} 到 /topics/1/replies/1" do
      route_for(:controller => "replies", :action => "destroy", :topic_id => 1, :id => 1).should == "/topics/1/replies/1"
    end
  end

  describe "路由确认" do

    it "应该可以从 GET /topics/1/replies/new 生成参数 { :controller => 'replies', action => 'new', :topic_id => '1' } " do
      params_from(:get, "/topics/1/replies/new").should == {:controller => "replies", :action => "new", :topic_id => '1'}
    end
  
    it "应该可以从 POST /topics/1/replies 生成参数 { :controller => 'replies', action => 'create', :topic_id => '1' }" do
      params_from(:post, "/topics/1/replies").should == {:controller => "replies", :action => "create", :topic_id => '1'}
    end
  
    it "应该可以从 GET /topics/1/replies/1/edit 生成参数 { :controller => 'replies', action => 'edit', :topic_id => '1', id => '1' }" do
      params_from(:get, "/topics/1/replies/1/edit").should == {:controller => "replies", :action => "edit", :topic_id => '1', :id => "1"}
    end
  
    it "应该可以从 PUT /topics/1/replies/1 生成参数 { :controller => 'replies', action => 'update', :topic_id => '1', id => '1' } " do
      params_from(:put, "/topics/1/replies/1").should == {:controller => "replies", :action => "update", :topic_id => '1', :id => "1"}
    end
  
    it "应该可以从 DELETE /topics/1/replies/1 生成参数 { :controller => 'replies', action => 'destroy', :topic_id => '1', id => '1' }" do
      params_from(:delete, "/topics/1/replies/1").should == {:controller => "replies", :action => "destroy", :topic_id => '1', :id => "1"}
    end
  end
end
