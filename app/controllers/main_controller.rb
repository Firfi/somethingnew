class MainController < ApplicationController

  # caches_page :index

  def index
    if current_user
      redirect_to :notes
    else
      respond_to :html
    end

  end
end
