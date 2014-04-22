class UserTanksController < ApplicationController
  before_action :set_user_tank, only: [:show, :edit, :update, :destroy]

  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /user_tanks
  # GET /user_tanks.json
  def index
    @user_tanks = UserTank.all
  end

  # GET /user_tanks/1
  # GET /user_tanks/1.json
  def show
  end

  # GET /user_tanks/new
  def new
    @user_tank = UserTank.new
    @tanks = set_tanks
  end

  def set_tanks

    if current_user.tanks.count == Tank.count
      return nil
    else
      return Tank.all.reject{|tank| tank.users.include? current_user}
    end
  end

  # GET /user_tanks/1/edit
  def edit

  end

  # POST /user_tanks
  # POST /user_tanks.json
  def create
    @user_tank = UserTank.new(user_tank_params)
    @user_tank.user = current_user

    respond_to do |format|
      if @user_tank.save
        format.html { redirect_to @user_tank, notice: 'The tank was successfully added to your account!' }
        format.json { render action: 'show', status: :created, location: @user_tank }
      else
        @tanks = set_tanks
        format.html { render action: 'new' }
        format.json { render json: @user_tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_tanks/1
  # PATCH/PUT /user_tanks/1.json
  def update
    respond_to do |format|
      if @user_tank.user == current_user or current_user.admin

         if @user_tank.update(user_tank_params)
            format.html { redirect_to @user_tank, notice: 'User tank was successfully updated.' }
            format.json { head :no_content }
         else
            format.html { render action: 'edit' }
            format.json { render json: @user_tank.errors, status: :unprocessable_entity }
         end

      else
        format.html { redirect_to @user_tank, notice:'You cannot update this tank'}

      end
    end
  end

  # DELETE /user_tanks/1
  # DELETE /user_tanks/1.json
  def destroy
    if @user_tank.user == current_user or current_user.admin

      @user_tank.destroy

      respond_to do |format|
        format.html { redirect_to user_tanks_url }
        format.json { head :no_content }
      end

    else

      respond_to do |format|
        format.html { redirect_to @user_tank, notice:'You cannot delete this tank'}

      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_tank
      @user_tank = UserTank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_tank_params
      params.require(:user_tank).permit(:user_id, :tank_id, :rating)
    end
end
