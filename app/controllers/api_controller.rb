class ApiController < ApplicationController
  before_action :check_session

  private
    def check_session
      @current_user = User.find(session[:user_id])
    rescue
      head :forbidden
    end
end
