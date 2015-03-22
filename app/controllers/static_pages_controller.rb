class StaticPagesController < ApplicationController
  def home
  	@pic = current_user.pics.build if signed_in?
#    @feed_items = current_user.pics.paginate(page: params[:page])

  end

  

  def contact
  end
end
