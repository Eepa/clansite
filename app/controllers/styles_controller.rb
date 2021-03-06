class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_admin_user, except: [:index, :show]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /styles
  # GET /styles.json
  def index
    @styles = Style.all
  end

  # GET /styles/1
  # GET /styles/1.json
  def show
  end

  # GET /styles/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles
  # POST /styles.json
  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save

        create_entry_successfully(@style, 'Style was successfully created.', format)

      else

        modify_entry_fails(@style, 'new', format)
      end
    end
  end

  # PATCH/PUT /styles/1
  # PATCH/PUT /styles/1.json
  def update
    respond_to do |format|
      if @style.update(style_params)

        modify_entry_successfully(@style,  'Style was successfully updated.' , format)
      else


        modify_entry_fails(@style, 'edit', format)
      end
    end
  end

  # DELETE /styles/1
  # DELETE /styles/1.json
  def destroy
    @style.destroy
    respond_to do |format|

      destroy_entry(styles_url, format)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_style
    @style = Style.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def style_params
    params.require(:style).permit(:name, :description)
  end
end
