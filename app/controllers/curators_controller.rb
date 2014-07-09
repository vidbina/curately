class CuratorsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  before_action :set_curator, only: [:show, :edit, :update, :destroy]

  # GET /curators
  # GET /curators.json
  def index
    @curators = Curator.all
  end

  # GET /curators/1
  # GET /curators/1.json
  def show
  end

  # GET /curators/new
  def new
    @curator = Curator.new
  end

  # GET /curators/1/edit
  def edit
  end

  # POST /curators
  # POST /curators.json
  def create
    @curator = Curator.create(curator_params)

    respond_to do |format|
      if @curator.save
        format.html { redirect_to @curator, notice: 'Curator was successfully created.' }
        format.json { render :show, status: :created, location: @curator }
      else
        format.html { render :new }
        format.json { render json: @curator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /curators/1
  # PATCH/PUT /curators/1.json
  def update
    respond_to do |format|
      if @curator.update(curator_params)
        format.html { redirect_to @curator, notice: 'Curator was successfully updated.' }
        format.json { render :show, status: :ok, location: @curator }
      else
        format.html { render :edit }
        format.json { render json: @curator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /curators/1
  # DELETE /curators/1.json
  def destroy
    @curator.destroy
    respond_to do |format|
      format.html { redirect_to curators_url, notice: 'Curator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curator
      @curator = Curator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def curator_params
      params.require(:curator).permit(:name, :shortname)
    end
end
