class PaymentDocumentsController < ApplicationController
  before_action :set_payment_document, only: [:insert]
  before_filter :authenticate_user!

  respond_to :html

  def generate
    @open_subscriptions = Subscription.payment_documents_to_be_generated
    respond_with(@open_subscriptions)
  end

  def insert
    debugger
    params = payment_document_params
    params[:generated] = true
    @payment_document.update(params)
    PaymentDocument.mark_as_generated_by_subscription(@payment_document.subscription_id)
    redirect_to action: :generate
  end

  def payment
    @payment_documents = PaymentDocument.to_be_confirmed
    respond_with @payment_documents
  end

  def confirm
    debugger
    PaymentDocument.process_paid_list(params[:payment])
    redirect_to action: :payment
  end

  def new
    @subscription = Subscription.find params[:subscription_id]
    @financial_banks = Bank.financial
    redirect_to subscriptions_path if @subscription == nil
    @payments = []
    for i in 1..@subscription.payments_quantity
      @payments << PaymentDocument.new
    end
  end

  def edit
    @subscription = Subscription.find params[:subscription_id]
    respond_with @subscription
  end

  def update
    payments = params[:payments]
    PaymentDocument.update_list payments
    redirect_to payment_documents_generate_url
  end

  # criar aqui código de desvio caso seja usuário master lançando
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
        debugger
        np << { kind: "C",
                generated: true,
                origin_bank: payments[i][:origin_bank],
                agency: payments[i][:agency],
                account: payments[i][:account],
                document_number: payments[i][:document_number], 
                due_date: payments[i][:due_date], 
                bank_id: payments[i][:bank_id],
                emittent: payments[i][:emittent],
                value: payments[i][:value] }
      end
      np
    end

    def set_payment_document
      @payment_document = PaymentDocument.find(params[:payment_document][:id])
    end

    def payment_document_params
      params.require(:payment_document).permit(:id, :doc_file, :payments, :bank_id)
    end

end
