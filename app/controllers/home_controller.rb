class HomeController < ApplicationController
  def index
    @comments = Comment.all
  end
  def create
    @comment = Comment.new(body: params[:body])
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end
end
