class StaticPageController < ApplicationController
  def index
    @users = User.all
  end

  def about
    render 'about'
  end

  def home
    render 'home'
  end

  def help
    render 'help'
  end
end
