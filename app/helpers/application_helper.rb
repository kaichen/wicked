# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_time(time)
    time.strftime("%F %H:%M")
  end

  def where_am_i(path)
    if path == '/forums'
      return '论坛首页'
    elsif /^\/forums\/\d$/ =~ path
      forum_id = path[/\d/].to_i
      return "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;#{Forum.find(forum_id).name}"
    elsif /^\/topics\/\d/ =~ path
      frm = Topic.find(path[/\d$/].to_i).forum
      fid = "/forums/#{frm.id}"
      return "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;<a href='#{fid.to_s}'>#{frm.name}</a>"
    elsif /^\/forums\/\d\/topics\/\d$/ =~ path
      frm = Forum.find(path[/\d/].to_i)
      fid = "/forums/#{frm.id}"
      return "<a href='/forums'>论坛首页</a>&nbsp;&mdash;&gt;&nbsp;<a href='#{fid.to_s}'>#{frm.name}</a>"
    else
      return '未知路径'
    end 
  end
  
  def where
    return "<div id='foruminfo'><span id='where'>#{where_am_i(request.path)}</span></div>"
  end
end
