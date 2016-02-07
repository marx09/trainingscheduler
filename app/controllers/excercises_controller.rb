class ExcercisesController < ApplicationController
  def index
    redirect_to "/" if cannot? :manage, Excercise
    @excercises = Excercise.all
    @excercise = Excercise.new
  end
  
  def create
    @excercise = Excercise.new(excercise_params)
    respond_to do |format|
      if can?(:manage, @excercise) && @excercise.save
        flash[:success] = 'Excercise was successfully created.'
        format.js   { render action: 'add_item', status: :created, location: @excercise }
      else
        format.js   { render json: @excercise.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @excercise = Excercise.find(params[:id])
    redirect_to "/" if cannot? :manage, @excercise
  end
  
  def update
    @excercise = Excercise.find(params[:id])
    respond_to do |format|
      if can?(:manage, @excercise) && @excercise.update(excercise_params)
        flash[:success] = 'Excercise was successfully updated.'
        format.js   { render action: 'show', status: :updated }
      else
        format.js   { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    excercise = Excercise.find(params[:id])
    if can? :manage, excercise
      excercise.destroy
      redirect_to '/excercises', success: 'Excercise deleted.'
    end
  end
  
  def excercise_params
    params.require(:excercise).permit(:name, :description, :reverse_weight)
  end
end
