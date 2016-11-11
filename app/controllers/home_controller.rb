class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.all { render text: '' }
    end
  end
end
