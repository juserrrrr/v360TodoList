class UsersController < ApplicationController
  allow_unauthenticated_access
  redirect_authenticated_user

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_session_path, notice: "User was successfully created. Please sign in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Apenas permitir uma lista de parâmetros confiáveis através.
    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
    end
end
