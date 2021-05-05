class SessionsController < ApplicationController
	def new
	    if logged_in?
	      redirect_to "/", notice: "You already signed in!"
	    end
	end

	def create
		user = User.find_by(email: params[:email])
	    	if user && user.authenticate(params[:password])
		      	session[:user_id] = user.id
		      	flash[:notice] = "Welcome back, " + user.name + "!"
		      	redirect_to '/'
	      	else
	    	 	# flash[:notice] = "Email and password mismatched. Try again."
	       		respond_to do |format|
	          		format.html { redirect_to '/sign_in' }
	          		format.js
	        	end
      		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged out sucessfuly. We will miss you ;("
    	redirect_to '/'
	end
end
