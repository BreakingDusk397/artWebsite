class AdminController < ApplicationController
    def authenticate_admin_user!
        if !current_user.is_admin
          flash[:error] = "You must be admin to access this page."
          redirect_to root_path
          return
        end
      
    end
end
