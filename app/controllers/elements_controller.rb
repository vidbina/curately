class ElementsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parents
  before_action :set_element, only: [:show, :edit, :update, :destroy]
  before_action :set_elements, only: [:index]

  load_and_authorize_resource :curator
  load_and_authorize_resource :template
  load_resource :element

  def index
  end

  def show
  end

  def new
    @element = @template.elements.new
  end

  def edit
  end

  def create
    @element = @template.elements.build(element_params)

    respond_to do |format|
      if @element.save
        format.html { redirect_to curator_template_element_url(@curator.id, @element.id), notice: 'Element was successfully created.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { render :new }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @element.update_attributes!({name: 'Spock'})
        format.html { redirect_to curator_template_element_url(@curator.id, @element.id), notice: 'Element was successfully updated.' }
        format.json { render :show, status: :ok, location: @element }
      else
        format.html { render :edit }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @element.destroy
    respond_to do |format|
      format.html { redirect_to curator_template_elements_url(@curator), notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def load_parents
    @curator = Curator.find(params[:curator_id])
    @template = @curator.template
  end

  def set_element
    @element  = @template.elements.find(params[:id])
  end

  def set_elements
    @elements = @template.elements
  end

  def element_params
    params.require(:element).permit(:name)
  end
end
