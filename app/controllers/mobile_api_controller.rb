class MobileApiController < ApplicationController
  def register
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @user = User.new
      @user.name = params[:name]
      @user.email  = params[:email]
      @user.password = params[:password]
      if @user.save
        @r = MobileApiResponse.new
        @r.user_id = @user.id
        @r.token = Digest::MD5.hexdigest(@user.id.to_s+"Wi11")
      else
        @r = MobileApiError.new
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  def login
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @user = User.authenticate params[:email], params[:password]
      if @user
        @r = MobileApiResponse.new
        @r.user_id = @user.id
        @r.token = Digest::MD5.hexdigest(@user.id.to_s+"Wi11")
      else
        @r = MobileApiError.new
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  def fb_login
  end

  def twitter_login
  end

  def upload
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @user = User.find_by_id(params[:user_id])
      @story = Story.new
      @story.title = params[:title]
      @story.prompt_id = params[:prompt_id]
      text_file = params[:text]
      audio_file = params[:audio]
      if text_file
        text = text_file.read
      end
      if audio_file
        if uploaded_audio.content_type = "audio/mp3"
          extension = ".mp3"
        elsif uploaded_audio.content_type = "audio/m4a"
          extension = ".m4a"
        end
        AWS::S3::S3Object.store(token+"/"+token+extension,uploaded_audio.read,AMAZON_NATARRE_BUCKET,:access => :public_read)
        has_audio=true
      end
      @story.has_audio=has_audio
      @story.token = Digest::MD5.hexdigest(@story.title+Time.now.to_i.to_s)
      if @story.save
        @r = MobileApiResponse.new
        @r.story_id=@story.id
      else
        @r = MobileApiError.new
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r

  end

  def comment
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      story_id=params[:story_id]
      user_id=params[:user_id]
      content=params[:comment]
      @comment = Comment.new
      @comment.story_id=story_id
      @comment.user_id=user_id
      @comment.content=content
      if @comment.save
        @r = MobileApiResponse.new
      else
        @r = MobileApiError.new
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end
  #443f730dcd996415d3cce948bbc3362c
  def story
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @story = Story.find_by_id params[:story_id]
      if @story
        if @story.has_audio
          audio_url = "http://s3.amazonaws.com/natarre.objects/"+@story.token+"/"+@story.token+".m4a"
        end
        if @story.has_thumbnail
          thumbnail_url = "http://s3.amazonaws.com/natarre.objects/"+@story.token+"/"+@story.token+".jpg"
        end
        @r = {
          :story_ID => @story.id,
          :author_ID => @story.user_id,
          :author_name => @story.user.name,
          :title => @story.title,
          :date_created => @story.created_at.to_i,
          :content => @story.content,
          :audio_file_url => audio_url,
          :thumbnail_file_url => thumbnail_url,
          :error_present => false
        }
      else
        @r = MobileApiError.new
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  def this_week
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      user_id = params[:user_id]
      @prompt = Prompt.find(:all,:order => "created_at DESC").first
      @r=@prompt

    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  def all_prompts
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @prompts = Prompt.all
      @r=@prompts
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  def forprompt
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @prompt = Prompt.find(params[:id])
      @r = Array.new
      @prompt.stories.each do |s|
        if s.has_audio
          audio_url = "http://s3.amazonaws.com/natarre.objects/"+s.token+"/"+s.token+".m4a"
        end
        if s.has_thumbnail
          thumbnail_url = "http://s3.amazonaws.com/natarre.objects/"+s.token+"/"+s.token+".jpg"
        end
        @r.push({
                  :story_ID => s.id,
                  :author_ID => s.user_id,
                  :author_name => s.user.name,
                  :title => s.title,
                  :date_created => s.created_at.to_i,
                  :content => s.content,
                  :audio_file_url => audio_url,
                  :thumbnail_file_url => thumbnail_url,
                  :error_present => false
        })
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end
  def popular
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @stories = Story.all(:order => "created_at DESC")
      @r = Array.new
      @stories.each do |s|
        if s.has_audio
          audio_url = "http://s3.amazonaws.com/natarre.objects/"+s.token+"/"+s.token+".m4a"
        end
        if s.has_thumbnail
          thumbnail_url = "http://s3.amazonaws.com/natarre.objects/"+s.token+"/"+s.token+".jpg"
        end
        @r.push({
                  :story_ID => s.id,
                  :author_ID => s.user_id,
                  :author_name => s.user.name,
                  :title => s.title,
                  :date_created => s.created_at.to_i,
                  :content => s.content,
                  :audio_file_url => audio_url,
                  :thumbnail_file_url => thumbnail_url,
                  :error_present => false
        })
      end
    else
      @r = MobileApiError.new
    end
    render :json => @r
  end

  
  class MobileApiError
    attr_accessor :error_number
    attr_accessor :error_string
    def initialize
      @error_present="true"
    end
  end
  class MobileApiResponse
    attr_accessor :user_id
    attr_accessor :story_id
    attr_accessor :token
    def initialize
      @error_present="false"
      @error_number="0"
    end
  end
end
