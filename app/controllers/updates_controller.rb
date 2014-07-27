class UpdatesController < ApplicationController
  #before_action :authenticate_user!
  before_action :load_parents
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  before_action :set_updates, only: [:index]

  #load_and_authorize_resource :board

  def index
    @updates = @board.updates
  end

  def show
  end

  def new
    @update = @board.updates.new
  end

  def edit
  end

  def create
    @update = @board.updates.build(update_params.symbolize_keys)

    respond_to do |format|
      if @update.save
        format.html { redirect_to board_update_url(@board, @update), notice: 'Update was successfully created.' }
        format.json { render :show, status: :created, location: @update }
      else
        format.html { render :new }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @update.update_attributes(update_params.symbolize_keys)
        format.html { redirect_to board_update_url(@board, @update), notice: 'Update was successfully updated.' }
        format.json { render :show, status: :ok, location: @update }
      else
        format.html { render :edit }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @update.destroy
    respond_to do |format|
      format.html { redirect_to board_updates_url(@board), notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def load_parents
    @board = Board.find(params[:board_id])
  end

  def set_update
    @update = @board.updates.find(params[:id])
  end

  def set_updates
    @updates = @board.updates
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def update_params
    params[:update]
  end
end
