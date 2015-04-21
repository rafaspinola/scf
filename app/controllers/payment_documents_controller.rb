class PaymentDocumentsController < ApplicationController
  before_action :set_payment_document, only: [:insert]
  before_filter :authenticate_user!

  respond_to :html

  def generate
    @open_subscriptions = Subscription.payment_documents_to_be_generated
    respond_with(@open_subscriptions)
  end

  def insert
    params = payment_document_params
    params[:generated] = true
    @payment_document.update(params)
    redirect_to action: :generate
  end

  def payment
    @payment_documents = PaymentDocument.to_be_confirmed
    respond_with @payment_documents
  end

  def new
    @subscription = Subscription.find params[:subscription_id]
    redirect_to subscriptions_path if @subscription == nil
    @payments = []
    for i in 1..@subscription.payments_quantity
      @payments << PaymentDocument.new
    end
  end

  def create
    @subscription = Subscription.find params[:subscription_id]
    a = build_payments(params[:payments])
    a.each do |p|
      @subscription.payment_documents.create(p)
    end
    redirect_to @subscription
  end

  private

    def build_payments(payments)
      np = []
      for i in 0..(payments.count - 1) do
        np << { kind: "C",
                bank: payments[i][:bank],
                agency: payments[i][:agency],
                account: payments[i][:account], 
                document_number: payments[i][:document_number], 
                due_date: payments[i][:due_date], 
                value: payments[i][:value] }
      end
      np
    end

    def set_payment_document
      @payment_document = PaymentDocument.find(params[:payment_document][:id])
    end

    def payment_document_params
      params.require(:payment_document).permit(:id, :doc_file, :payments)
    end

end
