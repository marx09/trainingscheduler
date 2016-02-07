class TrainingsController < ApplicationController
  def index
    @date = Date.today
    from = @date.beginning_of_week
    to = @date.end_of_week
    @trainings = Training.where(training_prototype: nil, date: from..to)
    @prototypes = TrainingPrototype.where("created_at - INTERVAL '1 days' * day <= ?", from).order(day: :asc).order(from: :asc)
    @training = Training.new
    @prototype = TrainingPrototype.new
  end
  
  def calendar_move
    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    from = @date.beginning_of_week
    to = @date.end_of_week
    @trainings = Training.where(training_prototype: nil, date: from..to)
    @prototypes = TrainingPrototype.where("created_at - INTERVAL '1 days' * day <= ?", from).order(day: :asc).order(from: :asc)
    respond_to do |format|
      format.js { render action: 'redraw_calendar', status: :accepted }
    end
  end
  
  def create
    @training = Training.new(training_params)
    respond_to do |format|
      if can?(:manage, @training) && @training.save
        flash[:success] = 'Training was successfully created.'
        format.html { redirect_to @training, notice: 'Training was successfully created.' }
        format.json { render action: 'add_item', status: :created, location: @training }
        format.js   { render action: 'add_item', status: :created, location: @training }
      else
        format.html { render action: 'new' }
        format.json { render json: @training.errors, status: :unprocessable_entity }
        format.js   { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @training = Training.find(params[:id])
  end
  
  def update
    @training = Training.find(params[:id])
    respond_to do |format|
      if can?(:manage, @training) && @training.update(training_params)
        flash[:success] = 'Training was successfully updated.'
        format.html { redirect_to @training, notice: 'Training was successfully updated.' }
        format.json { render action: 'show', status: :accepted }
        format.js   { render action: 'show', status: :accepted }
      else
        format.html { render action: 'edit' }
        format.json { render json: @training.errors, status: :unprocessable_entity }
        format.js   { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def plan_content
    redirect_to "/" if cannot?(:manage, Training)
    @training = Training.find(params[:id])
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
  
  def users
    training = Training.find(params[:id])
    
    respond_to do |format|
      if training
        @participants = training.users
        @available = User.where.not(id: training.users)
        format.html { render action: 'users', layout: false, status: :accepted }
       # format.json { render json: {training_users: training.users, available_users: users}, status: :accepted }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end
  
  def save_users
    @training = Training.find(params[:id])
    @training.users_hash = ActiveSupport::JSON.decode(params[:data_string])
    respond_to do |format|
      if @training.save
        flash[:success] = 'Users were successfully saved.'
        format.js { render action: 'show', status: :accepted, location: @training }
      else
        format.js { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def save_user_result
    if params[:result_id].empty?
      @result = Result.new()
      @result.user = User.find(params[:user_id])
      @result.serie = Serie.find(params[:serie_id])
    else
      @result = Result.find(params[:result_id])
    end
    
    @result.reps = params[:reps]
    @result.time = params[:time]
    @result.weight = params[:weight]

    respond_to do |format|
      if @result.save
        flash[:success] = 'Result was successfully saved.'
        format.js { render action: 'show_result', status: :accepted }
      else
        format.js { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def save_training_user_result
    if params[:result_id].empty?
      @result = TrainingResult.new()
      @result.user = User.find(params[:user_id])
      @result.training = Training.find(params[:training_id])
    else
      @result = TrainingResult.find(params[:result_id])
    end
    
    @result.calories = params[:calories]
    @result.time = params[:time]
    @result.rate = params[:rate]

    respond_to do |format|
      if @result.save
        flash[:success] = 'Training result was successfully saved.'
        format.js { render action: 'show_training_result', status: :accepted }
      else
        format.js { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @training = Training.find(params[:id])
    @training.destroy if can? :manage, @training
    redirect_to '/trainings'
  end
  
  def training_params
    params.require(:training).permit(:date, :from)
  end

end
