class ModulepagesController < ApplicationController
  include DashboardHelper
  before_action :authenticate_user!
  before_action :permit
  before_action :set_modulepage, only: [:show, :edit, :update, :destroy]

  layout "dashboard"

  # GET /modulepages
  # GET /modulepages.json
  def index
    @modulepages = Modulepage.all
  end

  # GET /modulepages/1
  # GET /modulepages/1.json
  def show
  end

  # GET /modulepages/new
  def new
    @modulepage = Modulepage.new
  end

  # GET /modulepages/1/edit
  def edit
  end

  # POST /modulepages
  # POST /modulepages.json
  def create
    @modulepage = Modulepage.new(modulepage_params)

    respond_to do |format|
      if @modulepage.save
        role = Role.where(alias: "superadmin").take

        if role
          @modulepage.roles << role
        end
        
        format.html { redirect_to modulepages_url, notice: 'Module was successfully created.' }
        format.json { render :show, status: :created, location: @modulepage }
      else
        format.html { render :new }
        format.json { render json: @modulepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modulepages/1
  # PATCH/PUT /modulepages/1.json
  def update
    respond_to do |format|
      if @modulepage.update(modulepage_params)
        format.html { redirect_to modulepages_url, notice: 'Module was successfully updated.' }
        format.json { render :show, status: :ok, location: @modulepage }
      else
        format.html { render :edit }
        format.json { render json: @modulepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modulepages/1
  # DELETE /modulepages/1.json
  def destroy
    @modulepage.roles.delete(@modulepage.roles)
    @modulepage.destroy
    respond_to do |format|
      format.html { redirect_to modulepages_url, notice: 'Module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modulepage
      @modulepage = Modulepage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modulepage_params
      params.require(:modulepage).permit(:name, :url)
    end
    
    def permit
      if !session[:role]
        redirect_to dashboard_url
      else
        if DashboardHelper.access_module(session[:role], "module")
          return true
        else
          respond_to do |format|
            format.html { redirect_to dashboard_url, notice: 'Permission denied.' }
          end
        end
      end
    end
end
