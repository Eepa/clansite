class ClansController < ApplicationController
  before_action :set_clan, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_user, except: [:index, :show]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /clans
  # GET /clans.json
  def index
    @clans = Clan.all
  end

  # GET /clans/1
  # GET /clans/1.json
  def show
  end

  # GET /clans/new
  def new
    @clan = Clan.new
  end

  # GET /clans/1/edit
  def edit
  end

  # POST /clans
  # POST /clans.json
  def create
    @clan = Clan.new(clan_params)

    respond_to do |format|
      if @clan.save

        create_entry_successfully(@clan, 'Clan was successfully created.', format)
      else

        modify_entry_fails(@clan, 'new', format)
      end
    end
  end

  # PATCH/PUT /clans/1
  # PATCH/PUT /clans/1.json
  def update
    respond_to do |format|
      if @clan.update(clan_params)
       # format.html { redirect_to @clan, notice: 'Clan was successfully updated.' }
        #format.json { head :no_content }

        modify_entry_successfully(@clan,  'Clan was successfully updated.' , format)

      else
        #format.html { render action: 'edit' }
        #format.json { render json: @clan.errors, status: :unprocessable_entity }

        modify_entry_fails(@clan, 'edit', format)
      end
    end
  end

  # DELETE /clans/1
  # DELETE /clans/1.json
  def destroy
    @clan.destroy
    respond_to do |format|
      #format.html { redirect_to clans_url }
     # format.json { head :no_content }

      destroy_entry(clans_url, format)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_clan
    @clan = Clan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def clan_params
    params.require(:clan).permit(:name, :description)
  end
end
