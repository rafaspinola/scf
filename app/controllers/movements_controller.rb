class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @movements = Movement.all
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
      params.require(:movement).permit(:due_date, :description, :value, :course_class_id, :account_id, :result_center_id, :bank_id)
    end
end
