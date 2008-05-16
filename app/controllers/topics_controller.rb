class TopicsController < ApplicationController

  # GET /forums/1/topics/new
  def new
    redirect_to(forums_path) if params[:forum_id] == nil
    @topic = Topic.new
    @topic.forum_id = params[:forum_id].to_i
  end
  
  # GET /topics/1
  def show
    @topic = Topic.find(params[:id])
    @replies = @topic.replies.paginate :page => params[:page] || 1,:per_page=> 20

    respond_to do |format|
      @topic.hit!
      format.html # show.html.erb
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  def create
    @topic = Topic.new(params[:topic])
    respond_to do |format|
      if @topic.save
        flash[:notice] = 'Topic was successfully created.'
        format.html { redirect_to @topic }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topics/1
  def update
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(@topic)}
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    Topic.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to(topics_url) }
    end
  end
end
