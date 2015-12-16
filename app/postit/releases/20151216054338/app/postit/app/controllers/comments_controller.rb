class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :edit, :vote]
  before_action :require_login, only: [:new, :create, :vote]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def show
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:notice] = "Your comment successfully created."
      redirect_to @post
    else
      @post = Post.find(params[:post_id]) # <----- refresh comments HOW TO AVOID
      render :template => 'posts/show'
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: @comment)

    respond_to do |format|

      format.js

      format.html do
    
        if vote.valid?
          flash[:notice] = "Your vote is counted"
        else
          flash[:error] = "You can vote on the same comment once."
        end
        redirect_to :back
      end # format.html

    end # respond_to

  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

end