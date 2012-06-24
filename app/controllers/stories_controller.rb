
class StoriesController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end
    @stories = Story.all(:all,:order => "created_at DESC")
    @stories ||= Array.new
  end

  def prompts
    @prompt = Prompt.find(:all,:order => "created_at DESC").first
    @stories = Story.where(:prompt_id => @prompt.id).find(:all,:order => "created_at DESC" )
  end

  def popular
    @stories = Story.all(:order => "created_at DESC")

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
    if !session[:user_id]
      redirect_to login_path
    else
      @story = Story.new
    end

  end

  def create
    uploaded_audio = params[:audio]
    token = Digest::MD5.hexdigest(params[:title]+Time.now.to_i.to_s)
    if(params[:prompt_id])
      prompt_id = params[:prompt_id]
    end
    if uploaded_audio
      if uploaded_audio.content_type = "audio/mp3"
        extension = ".mp3"
      elsif uploaded_audio.content_type = "audio/m4a"
        extension = ".m4a"
      end
      AWS::S3::S3Object.store(token+"/"+token+extension,uploaded_audio.read,AMAZON_NATARRE_BUCKET,:access => :public_read)
      has_audio=true
 
    else
      has_audio=false
    end

    @story = Story.new
    @story.token = token
    @story.title = params[:title]
    @story.has_audio = has_audio
    @story.content = params[:content]
    @story.prompt_id = prompt_id
    @story.user_id = session[:user_id]
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
