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

        create_entry_successfully(@user, 'User was successfully created.', format)
      else


        modify_entry_fails(@user, 'new', format)
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    unless @user == current_user
      redirect_to @user, notice: 'You cannot update this user'
      return
    end

    respond_to do |format|

      if user_params[:name].nil? and @user.update(user_params)

        modify_entry_successfully(@user,  'User was successfully updated.' , format)
      else


        modify_entry_fails(@user, 'edit', format)
      end

    end
  end


  def update_clan_id

    respond_to do |format|
      if @user.update(:clan_id => update_clan_params[:clan_id])


        modify_entry_successfully(@user,  "You have successfully joined in a clan!" , format)
      else


        modify_entry_fails(@user, 'join_clan', format)
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

        destroy_entry(users_url, format)
      end

    else
      redirect_to users_path, notice:'You cannot delete this user'
    end


  end

  def join_clan
    @clans = Clan.all

  end

  def leave_clan
    if current_user == @user or current_user.admin


      respond_to do |format|

        if @user.update(:clan_id => nil)


          modify_entry_successfully(@user,  "You have successfully left the clan!" , format)
        else

          modify_entry_fails(@user, 'show', format)
        end
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
