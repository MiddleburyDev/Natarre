
class StoriesController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end
    @stories = Story.all(:order => "created_at DESC")
    @stories ||= Array.new
  end

  def prompts
    @prompt = Prompt.find(:all,:order => "created_at DESC").first
  end

  def popular
    @stories = Story.all

  end

  def show
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
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
    uploaded_audio = params[:audio]
    token = Digest::MD5.hexdigest(params[:title]+Time.now.to_i.to_s)

    if uploaded_audio

      AWS::S3::S3Object.store(token+"/"+token+".mp3",uploaded_audio.read,AMAZON_NATARRE_BUCKET)
      sc_id=1
 
    else
      sc_id=0
    end

    @story = Story.new
    @story.token = token
    @story.title = params[:title]
    @story.sc_id = sc_id
    @story.content = params[:content]
    if @story.save
      redirect_to :root
    else
      # if save fails
    end
  end

  def new
    @story = Story.new
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
