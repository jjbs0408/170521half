class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:create, :read, :new]
  def intro

  end
  def index

    # @posts = Post.all.sort_by(&:date)
    # @posts.save
    @posts = Post.all

    # @posts.paginate(:page => params[:page], :per_page => 5)
  end

  def new

  end

  def create
    @imgUploader = ImgUploader.new
    @imgUploader.store!(params[:img])
    @user = User.find(current_user.id)
    # Post.create(user_id: @user.id, title: params[:title], content: params[:content],
    #             date: params[:_date], img: @imgUploader.url)

    @post = @user.posts.new(title: params[:title], content: params[:content],
                            start_date: params[:start_date],end_date: params[:end_date],
                            img: @imgUploader.url, img_thumb: @imgUploader.thumb.url, abroad: params[:abroad],place:params[:place],
                            theme: params[:theme])
    @post.save

    # @post.img = @imgUploader.url
    # post = Post.new
    # post.title = params[:title]
    # post.content = params[:content]
    # post.date = params[:_date]
    # post.save

    # post = Post.new(title:params[:title], content:params[:content], date:params[:_date])
    # post.save

    redirect_to '/home/index'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy

    redirect_to '/home/index'
  end

  def read
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  end

  def real_update
    @post = Post.find(params[:id])
    @post.date = params[:date]
    @post.title = params[:title]
    @post.content = params[:content]
    @post.save

    redirect_to '/'
    # redirect_to '/home/read/' + @post.id.to_s
  end

  def comment_create
    @user = User.find(current_user.id)
    # @comment = Comment.new(user_id: @user.id, post_id: params[:post_id], content: params[:content])
    @comment = @user.comments.new(post_id: params[:post_id], content: params[:content])
    @comment.save
    redirect_to :back
  end

  def comment_destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back
  end

end
