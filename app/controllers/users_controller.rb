class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @results = Excercise.joins(:series => :results).select('excercises.name, excercises.id, max(results.reps) as max_reps, max(results.weight) as max_weight, max(results.time) as max_time, min(results.time) as min_time').where(results: {user_id: @user}).group(:id)
  end
end
