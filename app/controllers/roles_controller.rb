class RolesController < ApplicationController
  include DashboardHelper
  before_action :authenticate_user!
  before_action :permit
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  layout "dashboard"

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    @modulepages = Modulepage.all
  end

  # GET /roles/1/edit
  def edit
    @modulepages = Modulepage.all
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    

    respond_to do |format|
      if @role.save

        params[:modulepages_roles][:modulepage_id].each do |x|
          if x!=""
            modulepage = Modulepage.find(x)
            modulepage.roles << @role
          end
        end

        if @role.alias == "superadmin"
          modulepages = Modulepage.all
          @role.modulepages << modulepages
        end
        
        format.html { redirect_to roles_url, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update

    respond_to do |format|
      if @role.update(role_params)

        @role.modulepages.delete(@role.modulepages)

        params[:modulepages_roles][:modulepage_id].each do |x|
          if x!=""
            @modulepage = Modulepage.find(x)
            @modulepage.roles << @role
          end
        end

        format.html { redirect_to roles_url, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.modulepages.delete(@role.modulepages)
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :alias)
    end

    def permit
      if !session[:role]
        redirect_to dashboard_url
      else
        if DashboardHelper.access_module(session[:role], "role")
          return true
        else
          respond_to do |format|
            format.html { redirect_to dashboard_url, notice: 'Permission denied.' }
          end
        end
      end
    end
end
