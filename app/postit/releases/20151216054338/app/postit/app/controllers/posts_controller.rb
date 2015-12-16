class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_login, only: [:new, :create, :update, :edit]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
    #binding.pry
  end

  def new
    @post = Post.new

  end

  def create
    @post = Post.new(post_params)
    # @post.user = User.first # TODO chage lataer
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your post successfully created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post successfully updated."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
  end

  def vote
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: @post)

    respond_to do |format|

      format.js

      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote is counted."
        else
          flash[:error] = "You can vote on the same post once."
        end
        redirect_to :back
      end # format.html

    end # respond_to

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
