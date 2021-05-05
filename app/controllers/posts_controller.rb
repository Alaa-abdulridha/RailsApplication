class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy, :apply]
	before_action :post_owner_check, only: [:edit, :update, :destroy]
	before_action :logged_in_check, :recruiter_check, only: [:new] 

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "Job post is created successfully!"
			redirect_to user_post_path(current_user.id, @post.id)
		else
			# flash[:notice] = "Something went wrong, please try again. (Please fill in all the fields)"
			respond_to do |format|
          		format.html { redirect_to new_user_post_path(current_user.id) }
          		format.js
        	end
			
		end
	end

	def show
	end

	def edit
	end

	def update
		@post.update(post_params)
		flash[:success] = "Job post has been updated successfully!"
		redirect_to user_post_path(@post.user_id, @post.id)
		@post.save
	end

	def destroy
		@post.destroy
		flash[:success] = "Job post has been deleted successfully!"
		redirect_to user_path(current_user.id)
	end

	def apply
		if (current_user.voted_for? @post) == false
			@post.upvote_by current_user
			flash[:success] = "Job application submitted successfully!"
			redirect_to user_post_path(@post.user_id, @post.id)
		elsif (current_user.voted_for? @post) == true
			respond_to do |format|
          		format.html { redirect_to user_post_path(@post.user_id, @post.id) }
          		format.js
        	end
        end
	end

	private

	def find_post 
		if @post = Post.find_by(id: params[:id])
			return @post
		else
			redirect_to "/", alert: "Post does not exist!"
		end
	end

	def logged_in_check
    	if current_user.nil?
    		redirect_to "/", alert: "Log in or Sign up first!"
    	end
  	end

  	def recruiter_check
  		if current_user.jobseeker?
  			redirect_to "/", alert: "Only recruiter has the access!"
  		end
  	end

	def post_owner_check
		if logged_in? and current_user.id != @post.user_id
			redirect_to "/", alert: "Only the post's owner has the access!"
		elsif !logged_in?
			redirect_to "/", alert: "Only the post's owner has the access!"
		end
	end

	def post_params
		params.require(:post).permit(:name, :description, :status, :user_id, :country, :zipcode, :state, :city, :date, :address)
	end
end
