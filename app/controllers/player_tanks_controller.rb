class PlayerTanksController < ApplicationController
  before_action :set_player_tank, only: [:show, :edit, :update, :destroy]

  # GET /player_tanks
  # GET /player_tanks.json
  def index
    @player_tanks = PlayerTank.all
  end

  # GET /player_tanks/1
  # GET /player_tanks/1.json
  def show
  end

  # GET /player_tanks/new
  def new
    @player_tank = PlayerTank.new
  end

  # GET /player_tanks/1/edit
  def edit
  end

  # POST /player_tanks
  # POST /player_tanks.json
  def create
    @player_tank = PlayerTank.new(player_tank_params)

    respond_to do |format|
      if @player_tank.save
        format.html { redirect_to @player_tank, notice: 'Player tank was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player_tank }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_tanks/1
  # PATCH/PUT /player_tanks/1.json
  def update
    respond_to do |format|
      if @player_tank.update(player_tank_params)
        format.html { redirect_to @player_tank, notice: 'Player tank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_tanks/1
  # DELETE /player_tanks/1.json
  def destroy
    @player_tank.destroy
    respond_to do |format|
      format.html { redirect_to player_tanks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_tank
      @player_tank = PlayerTank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_tank_params
      params.require(:player_tank).permit(:player_id, :tank_id, :rating)
    end
end
