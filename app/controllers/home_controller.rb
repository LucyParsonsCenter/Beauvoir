class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def about
  end

  # def frontpage
  #   render :layout => "frontpage"
  # end
  def frontpage
    render 'frontpage'
  end


  def interior
    render :layout => "frontpage"
  end

  def help
    render 'help'
  end
  
  def checkout
    render 'checkout'
  end
end
