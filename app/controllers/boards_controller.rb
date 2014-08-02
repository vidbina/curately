class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  authorize_resource :template

  # GET /boards
  # GET /boards.json
  def index
    curator_ids = current_user.curatorships.map { |c| c.curator.id }
    client_ids = current_user.memberships.map { |c| c.client.id }
    curated_boards = Board.in('curator.id' => curator_ids)
    subscribed_boards = Board.in('client.id' => client_ids)
    @boards = Board.or(curated_boards.selector, subscribed_boards.selector)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    respond_to do |format|
      @board = Board.new(curator: @curator, client: @client)
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(curator: @curator, client: @client)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_params
    if params[:board] && params[:board][:curator] && params[:board][:client]
      curator_id = params[:board][:curator][:id]
      client_id = params[:board][:client][:id]
      @curator = Curator.find(curator_id) if Curator.exists?(curator_id)
      @client = Client.find(client_id) if Client.exists?(client_id)
      @template = @curator.template
    end

    params.require(:board) #.permit(:content)
  end
end
