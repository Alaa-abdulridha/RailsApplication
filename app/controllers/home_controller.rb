class HomeController < ApplicationController

	def index
		@post = Post.includes(:user).where(status: 0).order(created_at: :desc).page params[:page]
	end

	def search
		if params[:search] != ""
           @results = Post.where('lower(name) iLIKE ?', "%#{params[:search]}%").order(:created_at)
           @user = User.where('lower(name) iLIKE ?', "%#{params[:search]}%").order(:created_at)
       end  
    end
end
