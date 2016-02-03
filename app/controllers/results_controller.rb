class ResultsController < ApplicationController
  def show_excercise
    @user = User.find(params[:user])
    @excercise = Excercise.find(params[:id])
    
    @results = Result.where(serie: @excercise.series, user: @user)
    
    @result = Excercise.joins(:series => :results).select('excercises.name, excercises.id, max(results.reps) as max_reps, max(results.weight) as max_weight, max(results.time) as max_time, min(results.time) as min_time').where(id: @excercise.id, results: {user_id: @user}).group(:id).first()
  end
  
  def show_training_results
    @user = User.find(params[:user])
  end
end
