require File.dirname(__FILE__) + '/../../spec_helper'

describe "/forums/new.html.erb" do
  include ForumsHelper
  
  before(:each) do
    @forum = Forum.new
    assigns[:forum] = @forum
  end

  it "should render new form" do
    render "/forums/new.html.erb"
    response.should have_tag("form[action=?][method=post]", forums_path) do
      with_tag 'p'
    end
  end
end


