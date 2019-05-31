class PostController < ApplicationController
    layout "admin"
    
    def index
        @page_title= "My Post";
    end
end
