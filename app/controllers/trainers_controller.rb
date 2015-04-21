class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @trainers = Trainer.all
    respond_with(@trainers)
  end

  def show
    respond_with(@trainer)
  end

  def new
    @trainer = Trainer.new
    respond_with(@trainer)
  end

  def edit
  end

  def create
    @trainer = Trainer.new(trainer_params)
    @trainer.save
    respond_with(@trainer)
  end

  def update
    @trainer.update(trainer_params)
    respond_with(@trainer)
  end

  def destroy
    @trainer.destroy
    respond_with(@trainer)
  end

  private
    def set_trainer
      @trainer = Trainer.find(params[:id])
    end

    def trainer_params
      params.require(:trainer).permit(:name, :bank, :agency, :account, :operation)
    end
end
