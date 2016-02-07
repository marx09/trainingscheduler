class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    redirect_to "/" if cannot? :manage, Group
    @groups = Group.all.order(created_at: :desc)
    @group = Group.new
    @available_users = User.where(group: nil)
  end
  
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if can?(:manage, @group) && @group.save
        flash[:success] = 'Group was successfully created.'
        format.js   { render action: 'add_item', status: :created, location: @group }
      else
        format.js   { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    redirect_to "/" if cannot? :manage, Group
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if can?(:manage, @group) && @group.update(group_params)
        flash[:success] = 'Group was successfully updated.'
        format.js   { render action: 'show', status: :updated }
      else
        format.js   { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    redirect_to "/" if cannot? :manage, Group
    @group = Group.find(params[:id])
    @available_users = User.where(group: nil)
  end
  
  def destroy
    group = Group.find(params[:id])
    if can?(:manage, group)
      group.destroy
      redirect_to '/groups', success: 'Group deleted. All members are available for adding to another group.'
    end
  end
  
  def add_user
    @group = Group.find(params[:id])
    @user = User.find(params[:user])
    @group.users << @user if @user.group.equal? nil
    respond_to do |format|
      if can?(:manage, @user) && @group.save
        flash[:success] = 'User was successfully added.'
        format.js   { render action: 'add_user', status: :updated }
      else
        format.js   { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def remove_user
    @user = User.find(params[:user])
    @user.group = nil
    respond_to do |format|
      if can?(:manage, @user) && @user.save
        @group = Group.find(params[:id])
        flash[:warning] = 'User was successfully removed.'
        format.js   { render action: 'remove_user', status: :updated }
      else
        format.js   { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def group_params
    params.require(:group).permit(:name)
  end
end
