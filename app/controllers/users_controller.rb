class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    layout "dashboard"

    def index
        @users = User.all
    end

    def new
        @user = User.new
        @roles = Role.all
    end

    def create

        @user = User.new(user_params)
        @user.save

        respond_to do |format|
            if @user.save

                params[:roles_users][:role_id].each do |x|
                    if x!=""
                        @role = Role.find(x)
                        @role.users << @user
                    end
                end
              
              format.html { redirect_to users_url, notice: 'User was successfully created.' }
              format.json { render :show, status: :created, location: @user }
            else
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
        

    end

    def edit
        @roles = Role.all
    end

    def update

        data = Hash.new
        data['email'] = params.require(:user)['email']
        if params.require(:user)['password']!=""
            data['password'] = params.require(:user)['password']
        end

        respond_to do |format|
          if @user.update(data)

            @user.roles.delete(@user.roles)

            params[:roles_users][:role_id].each do |x|
                if x!=""
                    @role = Role.find(x)
                    @role.users << @user
                end
            end
    
            format.html { redirect_to users_url, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
    end

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
