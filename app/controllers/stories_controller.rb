
class StoriesController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end

    @stories = Story.all(:order => "created_at DESC")
    @stories ||= Array.new
  end
  def prompts


  end
  def popular


  end
  def show
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end

	def new
		@story = Story.new
	end


    @story = Story.find_by_id(params[:id])
    @story ||= Story.find_by_id(params[:story_id])
    if @story

    else

    end
  end


  def new
    @story = Story.new

  end

  def create
    @story = Story.new params[:story]
    if @story.save
      redirect_to :root
    else

    end

  end

  def add_comment
    if session[:user_id]
      @comment = Comment.new
      @comment.content = params[:content]
      @comment.story_id = params[:story_id]
      @comment.user_id = params[:user_id]
      @comment.save
    end
    show
    redirect_to @story
  end




end
