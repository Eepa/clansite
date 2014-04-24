class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :leave_clan, :join_clan, :update_clan_id]
  before_action :ensure_that_signed_in, except: [:index, :show, :new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user == current_user
        if user_params[:name].nil? and @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @user, notice: 'You cannot update this user' }
      end
    end
  end


  def update_clan_id

      respond_to do |format|
        if @user.update(:clan_id => update_clan_params[:clan_id])
          format.html { redirect_to @user, notice: "You have successfully joined in a clan!" }
          format.json { head :no_content }
        else
          format.html { render action: 'join_clan' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

  end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      @user.destroy
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end

    else
       redirect_to users_path, notice:'You cannot delete this user'
    end


  end

  def join_clan
    @clans = Clan.all

  end

  def leave_clan

    respond_to do |format|

      if (current_user == @user and @user.update(:clan_id => nil)) or (current_user.admin and @user.update(:clan_id => nil))
        format.html { redirect_to user_url(@user), notice: "You have successfully left the clan!" }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  private
   def update_clan_params
    params.require(:user).permit(:clan_id)
   end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
