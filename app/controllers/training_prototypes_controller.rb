class TrainingPrototypesController < ApplicationController
  #def index
  #  @prototypes = TrainingPrototype.all.order(day: :asc).order(from: :asc)
  #  @prototype = TrainingPrototype.new
  #end
  
  def create
    @prototype = TrainingPrototype.new(prototype_params)
    respond_to do |format|
      if @prototype.save
        flash[:success] = 'Training plan was successfully created.'
        format.html { redirect_to @prototype, notice: 'Training plan was successfully created.' }
        format.json { render action: 'add_item', status: :created, location: @prototype }
        format.js   { render action: 'add_item', status: :created, location: @prototype }
      else
        format.html { render action: 'new' }
        format.json { render json: @prototype.errors, status: :unprocessable_entity }
        format.js   { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @prototype = TrainingPrototype.find(params[:id])
  end
  
  def update
    @prototype = TrainingPrototype.find(params[:id])
    respond_to do |format|
      if @prototype.update(prototype_params)
        flash[:success] = 'Training plan was successfully updated.'
        format.html { redirect_to @prototype, notice: 'Training plan was successfully updated.' }
        format.json { render action: 'show', status: :updated }
        format.js   { render action: 'show', status: :updated }
      else
        format.html { render action: 'edit' }
        format.json { render json: @prototype.errors, status: :unprocessable_entity }
        format.js   { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create_from
    prototype = TrainingPrototype.find(params[:id])
    training = Training.new
    training.date = params[:date]
    training.from_prototype_at = params[:date]
    training.from = prototype.from
    training.users << prototype.group.users
    prototype.trainings << training
    if prototype.save
      flash[:success] = 'Training was successfully created.'
      redirect_to training_path(training)
    else
      redirect_to training_prototypes_path
    end
  end
  
  def destroy
    @prototype = TrainingPrototype.find(params[:id])
    @prototype.destroy if can? :manage, @prototype
    redirect_to '/trainings'
  end
  
  def prototype_params
    params.require(:training_prototype).permit(:day, :from, :group_id)
  end
end
