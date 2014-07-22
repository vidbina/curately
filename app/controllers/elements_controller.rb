class ElementsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_element #, only: [:show, :edit, :update, :destroy]
  before_action :testthis

  load_and_authorize_resource :curator
  load_and_authorize_resource :template
  load_resource :element

  def index
    p "INDEX" #{@template
    @elements = [] # @template.elements
  end

  def show
  end

  def new
    @element = Element.new
  end

  def edit
  end

  def create
    @element = Element.new(element_params)

    respond_to do |format|
      if @element.save
        format.html { redirect_to @element, notice: 'Element was successfully created.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { render :new }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @element.update(element_params)
        format.html { redirect_to @element, notice: 'Element was successfully updated.' }
        format.json { render :show, status: :ok, location: @element }
      else
        format.html { render :edit }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @element.destroy
  end

  private
  def set_element
    #p "setting element"
    @curator = Curator.find(params[:curator_id])
    @template = @curator.template
    p "template is #{@template}"
    @element  = @template.elements.find(:id)
    p "element is #{@element}"
  end

  def testthis
    p "testing"
  end

  def element_params
    p({ curator_id: params[:curator_id] }.merge params.require(:element).permit(:name))
    { curator_id: params[:curator_id] }.merge params.require(:element).permit(:name)
  end
end
