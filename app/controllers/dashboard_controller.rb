class DashboardController < ApplicationController
    
    before_action :authenticate_user!
    layout "dashboard"

    def index
    end

    def choose_role
        session[:role] = params.require(:role)
        respond_to do |format|
            format.json { render json: {"hello"=>"bro"}, :status => 200 }
        end
    end
end
