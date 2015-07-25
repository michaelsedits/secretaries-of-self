class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        sign_in @user
        @cabinet = Cabinet.new(user_id: @user.id)
        @cabinet.save
        
        format.html { redirect_to :root, notice: 'Your account was created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    
  end
  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root, notice: 'Account was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end