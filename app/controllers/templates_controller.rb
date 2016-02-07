class TemplatesController < ApplicationController
  def index
    redirect_to "/" unless can? :manage, Template
    @templates = Template.all
    @template = Template.new
  end
  
  def create
    @template = Template.new(template_params)
    respond_to do |format|
      if can?(:manage, @template) && @template.save
        flash[:success] = 'Template was successfully created.'
        format.js   { render action: 'add_item', status: :created, location: @template }
      else
        format.html { render action: 'new' }
        format.json { render json: @template.errors, status: :unprocessable_entity }
        format.js   { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])
    respond_to do |format|
      if can?(:manage, @template) && @template.update(template_params)
        flash[:success] = 'Template was successfully updated.'
        format.js   { render action: 'show', status: :accepted }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template.errors, status: :unprocessable_entity }
        format.js   { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def plan_content
    @template = Template.find(params[:id])
    @excercises = Excercise.all
  end

  def save_content
    # save template and data
    @template = Template.find(params[:id])
    @template.data_hash = ActiveSupport::JSON.decode(params[:data_string])
    respond_to do |format|
      if can?(:manage, @template) && @template.save
        flash[:success] = 'Template was successfully saved.'
        format.js { render action: 'show', status: :accepted, location: @template }
      else
        format.js { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def all
    @templates = Template.all
    respond_to do |format|
      if can?(:manage, Template)
        format.json { render json: @templates, status: :accepted }
      else
        format.js { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def load
    @template = Template.find_by(id: params[:template])
    respond_to do |format|
      if can?(:manage, @template) && @template
        flash[:success] = 'Template was successfully loaded.'
        format.js { render action: 'load_template', status: :accepted, location: @template }
      else
        format.js { render json: { template: ["Cannot load template."]}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @template = Template.find(params[:id])
    @template.destroy if can? :manage, @template
    redirect_to '/templates'
  end
  
  def template_params
    params.require(:template).permit(:name)
  end
  
end
