# Results controller
class ResultsController < ApplicationController
  def show_excercise
    @user = User.find(params[:user])
    if can?(:manage, @user) || current_user.id.equal?(params[:user].to_i)
      @excercise = Excercise.find(params[:id])
      @results = Result.where(serie: @excercise.series, user: @user)
      @result = Excercise.joins(series: :results)
        .select('excercises.name,
          excercises.id,
          max(results.reps) as max_reps, 
          max(results.weight) as max_weight,
          max(results.time) as max_time,
          min(results.time) as min_time')
        .where(id: @excercise.id, results: { user_id: @user }).group(:id).first
    else
      flash[:danger] = 'You are not allowed to enter this page.'
      redirect_to '/'
    end
  end

  def show_training_results
    if (can? :manage, User) || (current_user.id.equal? params[:user].to_i)
      @user = User.find(params[:user])
    else
      flash[:danger] = 'You are not allowed to enter this page.'
      redirect_to '/'
    end
  end
end
