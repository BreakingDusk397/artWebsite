class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :logged_in_user, only: %i[ edit update destroy ]
    before_action :correct_user, only: %i[ edit update ]
    before_action :admin_user, only: %i[ destroy index ]

    def dashboard
      # @users = User.all
      # @orders = Orders.all
    end

    # GET /users or /users.json
    def index
      @users = User.all
    end
  
    # GET /users/1 or /users/1.json
    def show
      @user = User.find(params[:id])
    end
  
    # GET /users/new
    def new
      @user = User.new(user_params)
      
        if @user.save
          log_in @user
          flash[:success] = "Welcome to the Sample App!"
          redirect_to @user
        else
          render 'new'
          flash[:error] = "Unsuccessful save."
        end
      
    end
  
    # GET /users/1/edit
    def edit
    end
  
    
    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /users/1 or /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    def login
      @user = User.new
      @user.email = params[:email]
    end
  
    def process_login
      if user = User.authenticate(params[:user])
        session[:id] = user.id
        redirect_to session[:return_to] || '/'
      else
        flash[:error] = 'Invalid login.'
        redirect_to :action => 'login', :username => params[:user][:username]
      end
    end
  
    def logout
      reset_session
      flash[:message] = 'Logged out.'
      redirect_to :action => 'login'
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end

      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end
end