class TemplatesController < ApplicationController
  def index
    @templates = Template.all
    @template = Template.new
  end
  
  def create
    @template = Template.new(template_params)
    respond_to do |format|
      if @template.save
        flash[:success] = 'Template was successfully created.'
        format.html { redirect_to @training, notice: 'Template was successfully created.' }
        format.json { render action: 'add_item', status: :created, location: @template }
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
      if @template.update(template_params)
        flash[:success] = 'Template was successfully updated.'
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { render action: 'show', status: :accepted }
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
    # save training and data
    @training = Training.find(params[:id])
    @training.data_hash = ActiveSupport::JSON.decode(params[:data_string])
    respond_to do |format|
      if @training.save
        flash[:success] = 'Training was successfully saved.'
        format.js { render action: 'show', status: :accepted, location: @training }
      else
        format.js { render json: @training.errors, status: :unprocessable_entity }
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
