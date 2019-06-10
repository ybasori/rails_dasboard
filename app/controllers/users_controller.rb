class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_modulepage, only: [:show, :edit, :update, :destroy]
  
    layout "admin"

    def index
        @users = User.all
    end

    def new
        @user = User.new
        errors= Hash.new
        errors['any?']=false
        @errors = OpenStruct.new(errors)
        data= Hash.new
        data['email']=""
        data['password']=""
        @previous_data = OpenStruct.new(data)
    end

    def create
        error_total=false
        error_count=0
        error_messages = Hash.new
        error_full_messages= Array.new
        data = Hash.new


        params.require(:user).each do |key, value|
            data[key]=value
            if value == ""
                message="can't be blank"
                error_messages[key]=message
                error_full_messages.push(key + " " + message)
                error_total = true
                error_count=error_count+1
            end
        end

        error_messages = OpenStruct.new(error_messages)

        errors = Hash.new
        errors['any?']=error_total
        errors['messages']=error_messages
        errors['detail']=error_messages
        errors['full_messages']=error_full_messages
        errors['count']=error_count

        errors=OpenStruct.new(errors)

        @errors = errors
        @user = User.new
        @user.email = params.require(:user)['email']

        

        @previous_data=OpenStruct.new(data)

        logger.debug @previous_data.email

        respond_to do |format|
            format.html { render :new }
            format.json { render json: @errors, status: :unprocessable_entity }
        end

    end

    def update
    end

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :encrypted_password)
    end
end
