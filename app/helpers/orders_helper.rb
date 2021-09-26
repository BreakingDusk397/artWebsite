module OrdersHelper
    # This will take in 500 cents and output $5.00
    def pretty_amount(amount_in_cents)
        number_to_currency(amount_in_cents / 100)
    end

end
