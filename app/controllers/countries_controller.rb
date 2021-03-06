class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_user, except: [:index, :show]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
  end

  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
       # format.html { redirect_to @country, notice: 'Country was successfully created.' }
      #  format.json { render action: 'show', status: :created, location: @country }

        create_entry_successfully(@country, 'Country was successfully created.', format)
      else
       # format.html { render action: 'new' }
       # format.json { render json: @country.errors, status: :unprocessable_entity }

        modify_entry_fails(@country, 'new', format)
      end
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
       # format.html { redirect_to @country, notice: 'Country was successfully updated.' }
       # format.json { head :no_content }

        modify_entry_successfully(@country,  'Country was successfully updated.' , format)
      else
       # format.html { render action: 'edit' }
       # format.json { render json: @country.errors, status: :unprocessable_entity }

        modify_entry_fails(@country, 'edit', format)
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country.destroy
    respond_to do |format|
     # format.html { redirect_to countries_url }
     # format.json { head :no_content }

      destroy_entry(countries_url, format)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Country.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.require(:country).permit(:name)
  end
end
