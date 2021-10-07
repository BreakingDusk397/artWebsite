class Order < ApplicationRecord
    enum status: { pending: 0, failed: 1, paid: 2 }
    belongs_to :user

    def self.create_customer(email: params[:user][:email], stripe_token: params[:order][:token])
        Stripe::Customer.create({
            api_key: Rails.application.credentials.dig(:stripe, :dev_private_key)
            email: params[:user][:email],
            
        })
    end
  
    def self.create_charge(customer_id: params[:order][:customer_id], amount: params[:order][:price], description: params[:order][:description])
        Stripe::Charge.create({
            api_key: Rails.application.credentials.dig(:stripe, :dev_private_key)
            customer: params[:order][:customer_id],
            amount: params[:order][:price],
            description: params[:order][:description],
            currency: 'usd'
        })
    end
    
end
