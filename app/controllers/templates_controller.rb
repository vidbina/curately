class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parents
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  authorize_resource :curator
  authorize_resource :template #, through: :curator

  def index
  end

  def show
  end

  def new
    #authorize! :manage, @curator
    redirect_to(curator_template_url(curator_id: @curator.id)) if @curator.template
    @template = Template.new
  end

  def edit
    unless @template
      #authorize! :manage, @curator
      redirect_to(curator_new_template_url(curator_id: params[:curator_id]))
    end
    #authorize! :manage, @templatae
  end

  def create
    @template = Template.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to curator_template_url(curator_id: params[:curator_id]), notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to curator_template_url(curator_id: params[:curator_id]), notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def load_parents
    @curator = Curator.find(params[:curator_id])
  end

  def set_template
    raise Mongoid::Errors::DocumentNotFound unless @curator.template_id
    @template = Template.find(@curator.template_id.to_bson_id)
  end

  def template_params
    params[:curator_id] = params[:curator_id]
    params.require(:template).permit(:name)
  end
end
