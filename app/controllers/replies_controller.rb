class RepliesController < ApplicationController
  before_filter :load_topic

  # GET /topic/replies/new
  def new
    @reply =@topic.replies.build
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /topic/replies/1/edit
  def edit
    @reply = @topic.replies.find(params[:id])
  end

  # POST /topic/replies
  def create
    @forum = @topic.forum
    @reply = @topic.replies.build(params[:reply])

    respond_to do |format|
      if @reply.save
        flash[:notice] = 'Reply was successfully created.'
        format.html { redirect_to(@topic) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topic/replies/1
  def update
    @forum = @topic.forum
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = 'Reply was successfully updated.'
        format.html { redirect_to(@topic) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /topic/replies/1
  def destroy
    @topic.replies.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to(@topic) }
    end
  end

  # Before Loader
  def load_topic
    @topic = Topic.find(params[:topic_id])
  end

end
