
class StoriesController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end
    @stories = Story.all(:all,:order => "created_at DESC")
    @stories ||= Array.new
  end

  def prompt
    if params[:id]
      @prompt = Prompt.find(params[:id])
    else
      @prompt = Prompt.find(:all,:order => "created_at DESC").first
    end
    if @prompt
      @stories = Story.where(:prompt_id => @prompt.id).find(:all,:order => "created_at DESC" )
    end
  end
  def prompts
    @prompts = Prompt.all(:order => "created_at DESC")

  end
  def popular
    @stories = Story.all(:order => "created_at DESC")
    @stories.sort! do |a,b|
      b.votes.size.to_f/b.views.to_f<=> a.votes.size.to_f/a.views.to_f
    end
  end

  def show
    if session[:user_id]
      @user = User.find_by_id session[:user_id]
    end
    @story = Story.find_by_id(params[:id])
    @story ||= Story.find_by_id(params[:story_id])
    if @story
      @story.views+=1
      @story.save
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
    @story.views=1
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

  def add_vote
    if session[:user_id]
      @vote = Vote.where(:user_id=>session[:user_id], :story_id=>params[:id])
      if @vote.empty?
        @vote = Vote.new
        @vote.story_id = params[:id]
        @vote.user_id = session[:user_id]
        @vote.save
      end
    end
    show
    redirect_to @story
  end

  def add_list
    if session[:user_id]
      @list = List.where(:user_id=>session[:user_id], :story_id=>params[:id])
      if @list.empty?
        @list = List.new
        @list.story_id = params[:id]
        @list.user_id = session[:user_id]
        @list.save
      end
    end
    show
    redirect_to @story
  end
  def show_list
    if session[:user_id]
      @lists = List.where(:user_id=>session[:user_id])
      @listed_stories = Array.new
      @lists.each do |a| @listed_stories.push a.story_id end
      @listed_stories = Story.find(@listed_stories)
      @favorites = Vote.where(:user_id=>session[:user_id])
      @favorited_stories = Array.new
      @favorites.each do |a| @favorited_stories.push a.story_id end
      @favorited_stories = Story.find(@favorited_stories)
    end
  end
  def remove_list
    if session[:user_id]
      @list = List.where(:user_id=>session[:user_id], :story_id=>params[:id]).first
      @list.destroy 
    end
    redirect_to show_list_path
  end
  def remove_vote
    if session[:user_id]
      @favorite = Vote.where(:user_id=>session[:user_id], :story_id=>params[:id]).first
      @favorite.destroy 
    end
    redirect_to show_list_path    
  end

end
