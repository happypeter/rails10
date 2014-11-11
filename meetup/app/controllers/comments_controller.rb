class CommentsController < ApplicationController
  def create
    c = Comment.new
    c.username = params[:username]
    c.email = params[:email]
    c.content = params[:content]
    c.issue_id = params[:issue_id]
    c.save
    redirect_to c.issue
  end
end
