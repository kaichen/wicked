require File.dirname(__FILE__) + '/../spec_helper'

describe TopicsController do
   describe "处理 GET /topics/1" do

    before(:each) do
      @topic = mock_model(Topic, :id => 1, 
                          :title => 'topic_title', 
                          :body => 'bodybodybodybodybody',
                          :replies => [mock_model(Reply)])
      @topic.stub!(:hit!)
      @topic.replies.stub!(:sort_by)
      Topic.stub!(:find).with(anything()).and_return(@topic)
      @params = {:id => @topic.id}
      
    end
  
    def do_get
      get :show, @params
    end

    it "应该可以成功响应" do
      do_get
      response.should be_success
    end
  
    it "应该可以成功渲染show.html.erb模板" do
      do_get
      response.should render_template('show')
    end
  
    it "应该可以调用视图的主题" do
      do_get
      assigns[:topic].should == @topic
    end
  end

  describe "处理 GET /topics/new" do

    it "应该在forum_id参数为空时跳转回到首页" do
      get :new
      response.should redirect_to(forums_url)
    end

  end

  describe "处理 GET /forums/1/topics/new" do

    before(:each) do
      @topic = mock_model(Topic,
                          :id => 1,
                          :replies => [@reply],
                          :forum_id => 1 )
      Topic.stub!(:new).and_return(@topic)
      @topic.stub!(:forum_id=)
      @params = { :forum_id => 1 }
    end
  
    def do_get
      get :new, @params
    end

    it "应该可以成功响应" do
      do_get
      response.should be_success
    end
  
    it "应该渲染new模板" do
      do_get
      response.should render_template('new')
    end
  
    it "应该可以创建一个新的帖子" do
      do_get
      assigns[:topic].should == @topic
    end
    
    it "应该创建的帖子属于某个论坛" do
      do_get
      assigns[:topic].forum_id.should == 1
    end
  
    it "应该不会对帖子进行保存" do
      @topic.should_not_receive(:save)
      do_get
    end
  
    it "应该可以调用该视图的模板" do
      do_get
      assigns[:topic].should equal(@topic)
    end
  end

  describe "处理 GET /topics/1/edit" do

    before(:each) do
      @topic = mock_model(Topic,:id => 1)
      Topic.stub!(:find).with(anything()).and_return(@topic)
      @params = { :id =>'1' }
    end
  
    def do_get
      get :edit, @params
    end

    it "应该成功响应" do
      do_get
      response.should be_success
    end
  
    it "应该渲染edit.html.erb模板" do
      do_get
      response.should render_template('edit')
    end
  
    it "应该可以查找到请求" do
      Topic.should_receive(:find).and_return(@topic)
      do_get
    end
  
    it "应该可以在视图中调用到Topic" do
      do_get
      assigns[:topic].should equal(@topic)
    end
  end

  describe "处理 POST /topics" do

    before(:each) do
      @topic = mock_model(Topic, :id => 1, :tilte => 'test1', :body => 'bodybodybodybodybody')
      Topic.stub!(:new).with(anything()).and_return(@topic)
      @params = {:topic => 'topic', :forum_id => '1'}
    end
    
    describe "成功保存" do
  
      def do_post
        @topic.should_receive(:save).and_return(true)
        post :create,@params
      end
  
      it "应该可以创建一个新的主题" do
        Topic.should_receive(:new).with(anything()).and_return(@topic)
        do_post
      end

      it "应该重定向到新的主题" do
        do_post
        response.should redirect_to(topic_url(@topic))
      end
      
    end
    
    describe "保存失败" do

      def do_post
        @topic.should_receive(:save).and_return(false)
        post :create, @params
      end
  
      it "应该重新渲染'new'模板" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "处理 PUT /topics/1" do

    before(:each) do
      @topic = mock_model(Topic, :id => 1, :tilte => 'test1', :body => 'bodybodybodybodybody')
      Topic.stub!(:find).and_return(@topic)
      @params = { :id => 1 }
    end
    
    describe "应该可以成功更新" do

      def do_put
        @topic.should_receive(:update_attributes).and_return(true)
        put :update,@params 
      end

      it "应该可以查找到主题请求" do
        Topic.should_receive(:find).with("1").and_return(@topic)
        do_put
      end

      it "应该更新找到的帖子" do
        do_put
        assigns(:topic).should equal(@topic)
      end

      it "should assign the found topic for the view" do
        do_put
        assigns(:topic).should equal(@topic)
      end

      it "应该从定向到该主题" do
        do_put
        response.should redirect_to(topic_url(@topic))
      end

    end
    
    describe "with failed update" do

      def do_put
        @topic.should_receive(:update_attributes).and_return(false)
        put :update, @params
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /topics/1" do

    before(:each) do
      @topic = mock_model(Topic,:id => 1, :destroy => true)
      Topic.stub!(:find).with('1').and_return(@topic)
      @params = {:id => 1}
    end
  
    def do_delete
      delete :destroy, @params
    end

    it "should find the topic requested" do
      Topic.should_receive(:find).with("1").and_return(@topic)
      do_delete
    end
  
    it "should call destroy on the found topic" do
      @topic.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the topics list" do
      do_delete
      response.should redirect_to(topics_url)
    end
  end
end
