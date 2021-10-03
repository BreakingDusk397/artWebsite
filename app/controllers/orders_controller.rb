class OrdersController < ApplicationController

  def create
    if @carurrency).uniq.length > 1
      redirect_to pictures_path, alert: "You can not select pictures with different currencies in one checkout"
    else
      @session = Stripe::Checkout::Session.create({
        Stripe.api_key = Rails.application.credentials.stripe[:dev_api_key]
        customer: current_user.stripe_customer_id,
        billing_address_collection: 'required',
        shipping_address_collection: {
        allowed_countries: ['US', 'CA']},
        payment_method_types: ['card'],
        line_items: @cart{ |item| item.to_builder.attributes! },
        allow_promotion_codes: true,
        mode: 'payment',
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: cancel_url,
        automatic_tax: {enabled: true},
        metadata: {}
      })
      respond_to do |format|
        forma end
    end
  end

  def success
    if params[:session_id].present? 
      # session.delete(:cart)
      Stripe.api_key = Rails.application.credentials.stripe[:dev_api_key]
      session[:cart] = [] # empty cart = empty array
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
      @session_with_expand.line_items.data.each do |line_item|
        product = Picture.find_by(stripe_product_id: line_item.price.picture)
      end
    else
      redirect_to cancel_url, alert: "No info to display"
    end
  end

  def cancel
    
  end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
  def order_params
    params.require(:order).permit(:product_id, :user_id, :status, :token, :charge_id, :error_message, :customer_id, :price_cents)
  end

end
