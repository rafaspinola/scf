class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @movements = if (params[:sd] || params[:ed])
      Movement.all.includes(:account, :bank, :result_center).order(:due_date)
    else
      Movement.recent.includes(:account, :bank, :result_center).order(:due_date)
    end
    @movements = @movements.where("due_date >= ?", params[:sd]) if params[:sd] && !params[:sd].empty?
    @movements = @movements.where("due_date <= ?", params[:ed]) if params[:ed] && !params[:ed].empty?
    respond_with(@movements)
  end

  def show
    respond_with(@movement)
  end

  def new
    @movement = Movement.new
    respond_with(@movement)
  end

  def edit
  end

  def create
    @movement = Movement.new(movement_params)
    @movement.save
    respond_with(@movement)
  end

  def update
    @movement.update(movement_params)
    respond_with(@movement)
  end

  def destroy
    @movement.destroy
    respond_with(@movement)
  end

  private
    def set_movement
      @movement = Movement.find(params[:id])
    end

    def movement_params
      params.require(:movement).permit(:due_date, :description, :value, :course_class_id, :account_id, :result_center_id, :bank_id, :transfer, :to_bank_id, :credit)
    end
end
