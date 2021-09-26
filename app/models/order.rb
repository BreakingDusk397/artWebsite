class Order < ApplicationRecord
    enum status: { pending: 0, failed: 1, paid: 2 }
    belongs_to :user
    belongs_to :order

    def self.create_customer(email: email, stripe_token: stripe_token)
        Stripe::Customer.create(
            email: email,
            source: stripe_token
        )
    end
  
    def self.create_charge(customer_id: customer_id, amount: amount, description: description)
        Stripe::Charge.create(
          customer: customer_id,
          amount: amount,
          description: description,
          currency: 'usd'
        )
    end
    
end
