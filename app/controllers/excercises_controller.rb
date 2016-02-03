class ExcercisesController < ApplicationController
  def index
    @excercises = Excercise.all
    @excercise = Excercise.new
  end
  
  def create
    @excercise = Excercise.new(excercise_params)
    respond_to do |format|
      if @excercise.save
        flash[:success] = 'Excercise was successfully created.'
        format.html { redirect_to @group, notice: 'Excercise was successfully created.' }
        format.json { render action: 'add_item', status: :created, location: @excercise }
        format.js   { render action: 'add_item', status: :created, location: @excercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @excercise.errors, status: :unprocessable_entity }
        format.js   { render json: @excercise.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @excercise = Excercise.find(params[:id])
  end

  def update
    @excercise = Excercise.find(params[:id])
    if @excercise.update(excercise_params)
      redirect_to '/excercises', success: 'Excercise updated.'
    else
      redirect_to '/excercises'
    end
  end
  
  def update
    @excercise = Excercise.find(params[:id])
    respond_to do |format|
      if @excercise.update(excercise_params)
        flash[:success] = 'Excercise was successfully updated.'
        format.html { redirect_to @group, notice: 'Excercise was successfully updated.' }
        format.json { render action: 'show', status: :updated }
        format.js   { render action: 'show', status: :updated }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.js   { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    excercise = Excercise.find(params[:id])
    excercise.destroy
    redirect_to '/excercises', success: 'Excercise deleted.'
  end
  
  def excercise_params
    params.require(:excercise).permit(:name, :description, :reverse_weight)
  end
end
