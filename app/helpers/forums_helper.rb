module ForumsHelper

  def total_replies(f) 
    f.topics.inject(0) { |s, t| s += t.replies_count } + f.topics.length
  end
end
