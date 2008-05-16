require File.dirname(__FILE__) + '/../spec_helper'

describe SiteController do

  describe '处理 GET site/index' do 

    def make_request
      get 'index'
    end

    it "应该可以成功响应" do
      make_request
      response.should be_success
    end

    it "应该可以渲染模板" do
      make_request
      response.should render_template('index')
    end

    it "应该可以查找论坛回复最热的帖子和最新的帖子" do
      Topic.should_receive(:find).with(:all, 
                                       :order => 'hits DESC', 
                                       :limit => 10 )
      Topic.should_receive(:find).with(:all, 
                                       :order => 'created_at DESC', 
                                       :limit => 10 )
      make_request
    end

  end
=begin
  describe 'Get site/about' do

    it '...'

  end
=end
end
