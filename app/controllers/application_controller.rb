class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    helper_method :current_donor
    helper_method :logged_in?
    helper_method :require_logged_in
    helper_method :redirect_if_not_logged_in!
    before_action :require_logged_in, except: [:new, :create, :home]

    def logged_in?
        !!current_donor
    end

    def require_logged_in
        redirect_to root_path unless logged_in?
    end

    #private method is internal to the implementation of a class, and it can only be called by other instance methods of the class or its subclasses. 
    #Private methods are implicitly invoked on self, and may not be explicitly invoked on an object.
    private
  

    def current_donor
        @current_donor ||= Donor.find(session[:donor_id]) if session[:donor_id]
    end

    def redirect_if_not_logged_in!
        if !logged_in?
          flash[:message] = "You must be logged in to complete this action!"
          redirect_back fallback_location: root_path
        end
    end
end
