class Api::V1::SessionController < ApiController
  skip_before_action :check_session, except: :show

  # GET /api/v1/session/show
  def show
    # @current_user defined in check_session
    render json: @current_user
  end

  # POST /api/v1/session/create
  # Sign in
  def create
    valid_params = params.permit :name, :password
    valid_params[:email] = valid_params.delete :name if valid_params[:name] =~ /@/

    if @current_user = User.where(valid_params).first
      session[:user_id] = @current_user.id
      render json: @current_user
    else
      head :unauthorized
    end
  end

  # DELETE /api/v1/session/destroy
  # Sign out
  def destroy
    session[:user_id] = nil
    head :no_content
  end
end
