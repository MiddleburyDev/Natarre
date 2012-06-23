class MobileApiController < ApplicationController
  def register
    if params[:email] && params[:token] == Digest::MD5.hexdigest(params[:email]+"Te99y")
      @user = @user.new
      @user.name = params[:name]
      @user.email  = params[:email]
      @user.password = params[:password_digest]
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

      if @user.authenticate params[:email], params[:password_digest]
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
    attr_accessor :token
    def initialize
      @error_present="false"
      @error_number="0"
    end
  end
end
