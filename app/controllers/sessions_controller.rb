class SessionsController < ApplicationController

    def new
        @user = Donor.new
    end
 
    def create

    end

end