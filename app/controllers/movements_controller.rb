class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @movements = if params.count > 2
      Movement.all.includes(:account, :bank, :result_center, :course_class).order(:due_date)
    else
      Movement.recent.includes(:account, :bank, :result_center, :course_class).order(:due_date)
    end
    @movements = @movements.where("due_date >= ?", params[:sd]) if params[:sd] && !params[:sd].empty?
    @movements = @movements.where("due_date <= ?", params[:ed]) if params[:ed] && !params[:ed].empty?
    @movements = @movements.where("description LIKE ?", "%#{params[:d]}%") if params[:d] && !params[:d].empty?
    @movements = @movements.where("bank_id = ?", params[:b]) if params[:b] && !params[:b].empty?
    if params[:v] && !params[:v].empty? then
      v = params[:v].to_i
      @movements = @movements.where("value >= ? and value <= ?", v-1, v+1) 
    end
    @banks = Bank.all
    respond_with(@movements)
  end

  def accountant
    @movements = []
    @movements = Movement.where(accountable: true).where("due_date >= ? and due_date <= ?", params[:sd], params[:ed]) if params[:sd] && !params[:sd].empty? && params[:ed] && !params[:ed].empty?
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
      params.require(:movement).permit(:due_date, :description, :value, :course_class_id, :account_id, :result_center_id, :bank_id, :transfer, :to_bank_id, :credit, :accountable, :document_image, :receipt_image)
    end
end
