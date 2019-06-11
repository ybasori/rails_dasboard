class HomeController < ApplicationController

    layout "application"
    
    def index
        if current_user
            redirect_to dashboard_url
        end
    end
end
