class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash.now[:error1] = "Invalid email/password combination!!" 
  		@title = 'sign in'
  		render 'new'
  	else
  		sign_in user
  		#redirect_to user
  		redirect_back_or user
  	end
  end

  def destroy
  	sign_out
  	redirect_to signin_path, :flash => {:error1 => "You have Signed out.. " }
  end

end
