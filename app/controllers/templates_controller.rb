class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :curator
  load_and_authorize_resource :template #, through: :curator

  def index
  end

  def show
  end

  def new
    authorize! :manage, @curator
    redirect_to(curator_template_url(curator_id: @curator.id))
  end

  def edit
    unless @template
      authorize! :manage, @curator
      redirect_to(curator_new_template_url(curator_id: params[:curator_id]))
    end
    authorize! :manage, @templatae
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
  def set_template
    curator = Curator.find(params[:curator_id])
    @template = curator.template
  end

  def template_params
    params[:curator_id] = params[:curator_id]
    params.require(:template).permit(:name)
  end
end
