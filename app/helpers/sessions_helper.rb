module SessionsHelper
    # Logs in the given user.
        def log_in(user)
            session[:user_id] = user.id
        end
    
        def remember(user)
            user.remember
            cookies.permanent.encrypted[:user_info] = user.id
            cookies.permanent[:remember_token] = user.remember_token
    
        def current_user
            if (user_id = session[:user_id])
                @current_user ||= User.find_by(id: session[:user_id])
            elseif (user_id = cookies.encrypted[user_id])
                user = user.find_by(id: user_id)
                if user && user.authenticated?(cookies[:remember_token])
                    log_in user
                    @current_user = user
            end
        end
    
        def logged_in?
            !current_user.nil?
        end
    
        def log_out
            session.delete(:user_id)
            @current_user = nil
        end

        def forget(user)
            user.forget            
        end
    
        def log_out
            forget(current_user)
            session.delete(:user_id)
            @current_user = nil
        end
end