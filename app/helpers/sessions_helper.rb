module SessionsHelper

	def sign_in(user)
		#cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		cookies.signed[:remember_token] = { value: user.id, expires: 1.hour.from_now }
		cookies.signed[:remember_token] = [user.id, user.salt]
		
		current_user = user  # this is a method which is defined at line 12
		
	end

	def current_user=(user)
		@current_user = user   # setter method - it assigns the signed in user to @current_user
	end

	def current_user         # getter method ;  the instance variable @current_user shall be made persistent to use across various pages
		@current_user ||= user_from_remember_token        # this is same as @current_user = @current_user || user_from_remember_token
	end													  # for the first time - as @current_user is nil, so it assigns u_f_r_token to the variable @c_u and hits the data base; next time onwards it takes @c_user as it is not nil (which has the value of u_f_r_t which was returned for the first time) avoiding hitting the data base

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user?(user)
		user == current_user
	end

	def deny_access
		session[:return_to] = request.fullpath
		redirect_to signin_path, :flash => {:error1 => "Please sign in to access this page!"}
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

	def clear_return_to
		session[:return_to] = nil
	end

	private

	def user_from_remember_token
		User.authenticate_with_salt(*remember_token)  # here the * mark unwraps the [:remember_token] array. since it has id and salt
	end

	def remember_token
		cookies.signed[:remember_token] || [nil, nil]
	end


end
