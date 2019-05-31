class PostController < ApplicationController
    layout "admin"

    access admin: :all
    
    def index
        @page_title= "My Post";
    end
end
