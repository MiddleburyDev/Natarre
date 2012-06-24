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

  def story
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @story = Story.find_by_id params[:story_id]
      @story.user_name = @story.user.name
      @story.text_file_url = "http://s3.amazon.aws."
      @story.audio_file_url
      @story.thumbnail_file_url
      @story.error_present
    else

    end
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
