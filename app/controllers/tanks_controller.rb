class TanksController < ApplicationController
  before_action :set_tank, only: [:show, :edit, :update, :destroy]
  before_action :set_countries_and_styles_for_template, only: [:new, :edit, :create, :update]
  before_action :ensure_that_admin_user, except: [:index, :show]
  before_action :ensure_that_signed_in, except: [:index, :show]



  def set_countries_and_styles_for_template
    @countries = Country.all
    @styles = Style.all
  end
  # GET /tanks
  # GET /tanks.json
  def index
    @tanks = Tank.all
  end

  # GET /tanks/1
  # GET /tanks/1.json
  def show
  end

  # GET /tanks/new
  def new
    @tank = Tank.new

  end

  # GET /tanks/1/edit
  def edit
  end

  # POST /tanks
  # POST /tanks.json
  def create
    @tank = Tank.new(tank_params)

    respond_to do |format|
      if @tank.save
      #  format.html { redirect_to @tank, notice: 'Tank was successfully created.' }
      #  format.json { render action: 'show', status: :created, location: @tank }

        create_entry_successfully(@tank, 'Tank was successfully created.', format)
      else
        #format.html { render action: 'new' }
        #format.json { render json: @tank.errors, status: :unprocessable_entity }

        modify_entry_fails(@tank, 'new', format)
      end
    end
  end

  # PATCH/PUT /tanks/1
  # PATCH/PUT /tanks/1.json
  def update
    respond_to do |format|
      if @tank.update(tank_params)
       # format.html { redirect_to @tank, notice: 'Tank was successfully updated.' }
       # format.json { head :no_content }

        modify_entry_successfully(@tank,  'Tank was successfully updated.' , format)
      else
        #format.html { render action: 'edit' }
       # format.json { render json: @tank.errors, status: :unprocessable_entity }

        modify_entry_fails(@tank, 'edit', format)
      end
    end
  end

  # DELETE /tanks/1
  # DELETE /tanks/1.json
  def destroy
    @tank.destroy
    respond_to do |format|
     # format.html { redirect_to tanks_url }
      #format.json { head :no_content }

      destroy_entry(tanks_url, format)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tank
    @tank = Tank.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tank_params
    params.require(:tank).permit(:name, :description, :country_id, :tier_number, :style_id)
  end
end
