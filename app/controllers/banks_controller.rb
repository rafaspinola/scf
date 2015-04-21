class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @banks = Bank.all
    respond_with(@banks)
  end

  def show
    respond_with(@bank)
  end

  def new
    @bank = Bank.new
    respond_with(@bank)
  end

  def edit
  end

  def create
    @bank = Bank.new(bank_params)
    @bank.save
    respond_with(@bank)
  end

  def update
    @bank.update(bank_params)
    respond_with(@bank)
  end

  def destroy
    @bank.destroy
    respond_with(@bank)
  end

  private
    def set_bank
      @bank = Bank.find(params[:id])
    end

    def bank_params
      params.require(:bank).permit(:name)
    end
end
