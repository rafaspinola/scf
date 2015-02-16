class SalesmenController < ApplicationController
  before_action :set_salesman, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @salesmen = Salesman.all
    respond_with(@salesmen)
  end

  def show
    respond_with(@salesman)
  end

  def new
    @salesman = Salesman.new
    respond_with(@salesman)
  end

  def edit
  end

  def create
    @salesman = Salesman.new(salesman_params)
    @salesman.save
    respond_with(@salesman)
  end

  def update
    @salesman.update(salesman_params)
    respond_with(@salesman)
  end

  def destroy
    @salesman.destroy
    respond_with(@salesman)
  end

  private
    def set_salesman
      @salesman = Salesman.find(params[:id])
    end

    def salesman_params
      params.require(:salesman).permit(:name, :bank, :agency, :account, :operation)
    end
end
