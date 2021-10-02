class Picture < ApplicationRecord
    has_one_attached :image

    has_many :order

    # transform shopping cart pictures into an array of line items
    def to_builder
        Jbuilder.new do |picture|
        picture.price stripe_price_id
        picture.quantity 1
        end
    end



    after_create do
        product = Stripe::Product.create(name: :title)
        price = Stripe::Price.create(product: picture, unit_amount: self.price, currency: self.currency)
        update(stripe_picture_id: picture.id, stripe_price_id: price.id)
    end

end
