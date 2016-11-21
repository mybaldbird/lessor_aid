class Api::V1::UsersController < ApiController
  before_action :set_api_v1_user, only: [:show, :update, :destroy]
  skip_before_action :check_session, only: :create

  # GET /api/v1/users/1
  def show
    render json: @api_v1_user
  end

  # POST /api/v1/users
  def create
    @api_v1_user = User.new(api_v1_user_params)

    if @api_v1_user.save
      session[:user_id] = @api_v1_user.id
      render json: @api_v1_user, status: :created
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @api_v1_user.update(api_v1_user_params)
      render json: @api_v1_user, status: :ok
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @api_v1_user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_user
      @api_v1_user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_user_params
      params.permit :name, :password, :email
    end
end
