# Users controller
class UsersController < ApplicationController
  def show
    if (current_user.has_role? 'admin') || (current_user.id.equal? params[:id].to_i)
      @user = User.find(params[:id])
      @results = Excercise.joins(series: :results)
                          .select('excercises.name,
                            excercises.id,
                            max(results.reps) as max_reps,
                            max(results.weight) as max_weight,
                            max(results.time) as max_time,
                            min(results.time) as min_time')
                          .where(results: { user_id: @user }).group(:id)
    else
      flash[:danger] = 'You are not allowed to enter this page.'
      redirect_to '/'
    end
  end
end
