require File.dirname(__FILE__) + '/../spec_helper'

describe RepliesController do

  describe "处理 GET topic/1/replies/new" do

    before(:each) do 
      @forum = mock_model(Forum, :id => '1')
      @topic = mock_model(Topic, :id => '1',:forum => @forum,:replies => [@reply])
      @reply = mock_model(Reply,:topic => @topic)
      @topic.replies.stub!(:build).and_return(@reply)
      Topic.stub!(:find).with('1').and_return(@topic)
      @params = {:topic_id => @topic.id}
    end

    def  do_get
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

    it "应该可以创建一个新的回复" do
      @topic.replies.stub!(:build).and_return(@reply)
      do_get
      assigns[:reply].should == @reply
    end
  
    it "应该不会对回复进行保存" do
      @reply.should_not_receive(:save)
      do_get
    end
  
    it "应该可以调用该视图的模板" do
      do_get
      assigns[:reply].should equal(@reply)
    end
  end
 
  describe "处理 edit /topic/1/replies/edit" do
   
    before(:each) do
      @topic = mock_model(Topic,:id => 1,:replies=>[@reply])
      @reply = mock_model(Reply,:id => 1,:topic=>@topic)
      Topic.stub!(:find).with('1').and_return(@topic)
      @params = {:topic_id => @topic.id,:id => 1 }
    end
  
    def do_get
      get :edit, @params
    end
  
    it "应该能找到请求的回复" do
      @topic.replies.should_receive(:find).and_return(@reply)
      do_get
    end
  end  
  
  describe "处理 create",:share => true do
    before(:each) do
      @forum = mock_model(Forum, :id => '1')
      @topic = mock_model(Topic, :id => '1', :title => '无标题', 
                                 :body => 'hihihihihihihihihihih',
                                 :forum => @forum, :replies => [@reply])
      @reply = mock_model(Reply, :topic => @topic, :save => true)
      Topic.should_receive(:find).with('1').and_return(@topic)
      @topic.replies.stub!(:build).with(@params).and_return(@reply)
      @params = { :topic_id => @topic.id,
                  :forum_id => @topic.forum.id,
                  :title    => 'Ragnarok',
                  :body     => 'ragnarokrangarkratnonfgdsakl' }
    end 

    def do_post
      post :create, @params
    end

    it "应该对应某个帖子" do
      do_post
      assigns[:topic].should == @topic
    end

    describe '处理帖子回复' do
      it "应该可以成功创建回复" do
        do_post
      end

      it "应该可以回复帖子" do
        do_post
        assigns[:reply].should == @reply
      end
    end

    describe "创建失败" do

      def do_post
        @reply.should_receive(:save).and_return(false)
        put :create, @params
      end

      it "应该重新渲染 ‘new’" do
        do_post
        response.should render_template('new')
      end

    end

  end
  
  describe "handling PUT /topics/1" do

    before(:each) do
      @topic = mock_model(Topic, :id => 1, :tilte => 'test1', :body => 'bodybodybodybodybody', :forum => @forum, :replies => [@reply])
      @forum = mock_model(Forum, :id => 1, :topics =>[@topic])
      @reply = mock_model(Reply, :id => 1, :topic => @topic)
      @topic.stub!(:forum).and_return(@forum)
      @topic.replies.stub!(:find).and_return(@reply)
      Topic.stub!(:find).with('1').and_return(@topic)
      @params = { :reply => 'reply', :topic_id => @topic.id, :id => @reply.id }
    end
    
    describe "成功更新" do

      def do_put
        @reply.should_receive(:update_attributes).and_return(true)
        put :update,@params 
      end

      it "应该可以查找到回复请求" do
        @topic.replies.should_receive(:find).with("1").and_return(@reply)
        do_put
      end

      it "应该更新找到的回复" do
        do_put
        assigns(:reply).should equal(@reply)
      end

      it "应该指定请求回复的视图" do
        do_put
        assigns(:reply).should equal(@reply)
      end

      it "应该从定向到该回复" do
        do_put
        response.should redirect_to(topic_url(@topic))
      end

    end
    
    describe "更新失败" do

      def do_put
        @reply.should_receive(:update_attributes).and_return(false)
        put :update, @params
      end

      it "应该重新渲染 ‘edit’" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "处理 DELETE /topics/1/replies" do

    before(:each) do
      @topic = mock_model(Topic, :id => 1, :replies => [@reply])
      @reply = mock_model(Reply, :id => 1, :topic => @topic, :destroy => true)
      Topic.stub!(:find).with('1').and_return(@topic)
      @topic.replies.stub!(:find).with('1').and_return(@reply)
      @params = {:id => 1, :topic_id => @topic.id }
    end
  
    def do_delete
      delete :destroy, @params
    end

    it "should find the topic requested" do
      @topic.replies.should_receive(:find).with("1").and_return(@reply)
      do_delete
    end
  
    it "should call destroy on the found topic" do
      @reply.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the topics list" do
      do_delete
      response.should redirect_to(topic_url(@topic))
    end
  end

end
