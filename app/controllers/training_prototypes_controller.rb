# TrainingPrototypes controller
class TrainingPrototypesController < ApplicationController
  def create
    @prototype = TrainingPrototype.new(prototype_params)
    respond_to do |format|
      if can?(:manage, @prototype) && @prototype.save
        flash[:success] = 'Training plan was successfully created.'
        format.js { render action: 'add_item', status: :created, location: @prototype }
      else
        format.js { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @prototype = TrainingPrototype.find(params[:id])
    redirect_to '/' unless can? :manage, @prototype
  end

  def update
    @prototype = TrainingPrototype.find(params[:id])
    respond_to do |format|
      if can?(:manage, @prototype) && @prototype.update(prototype_params)
        flash[:success] = 'Training plan was successfully updated.'
        format.js { render action: 'show', status: :accepted }
      else
        format.js { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from
    prototype = TrainingPrototype.find(params[:id])
    if cannot?(:manage, prototype)
      redirect_to '/'
      return
    end
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
      redirect_to trainings_path
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
