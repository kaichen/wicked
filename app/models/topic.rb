class Topic < ActiveRecord::Base
  belongs_to :forum,:counter_cache => true
  has_many :replies,:dependent => :destroy
  validates_presence_of :title, :body
  validates_length_of :body, :minimum => 16

  def last_post
    if self.has_replies
      return self.replies.sort_by{ |rep| rep.created_at }.last
    else
      return self
    end
  end

  def replies_count
    replies.size
  end

  def last_post_time
    self.last_post.created_at
  end
  
  def <=> (other)
    self.last_post_time <=> other.last_post_time
  end

  def has_replies
    !(self.replies.nil? || self.replies.empty?) 
  end
  
  def do_reply(options = {})
    options.merge!(:title => '')
    replies.build(options)
  end

  def hit!
    self.class.increment_counter(:hits,id)
  end
end
