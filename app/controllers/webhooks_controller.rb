class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def create
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil

        begin
            event = Stripe::Webhook.construct_event(
                payload, sig_header, Rails.application.credentials[:stripe][:webhook]
            )
            rescue JSON::ParserError => e
                status 400
            return
            rescue Stripe::SignatureVerificationError => e
                # Invalid signature
                puts "Signature error"
                p e
            return
        end

        # Handle the event
        case event.type
            when 'orders.session.completed'
                session = event.data.object
                session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"]})
                session_with_expand.line_items.data.each do |line_item|
                    picture = Picture.find_by(stripe_product_id: line_item.price.picture)
                    picture.increment!(:sales_count)
                    order = Order.new(order_params)
            end
        end

        render json: { message: 'success' }
    end

    private
    def order_params
        params.require(:order).permit(:product_id, :user_id, :status, :token, :charge_id, :error_message, :customer_id, :price_cents)
    end

end
