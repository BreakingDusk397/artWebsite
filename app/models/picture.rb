class Picture < ApplicationRecord
    has_one_attached :image
    validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :description, presence: true, length: { maximum: 500 }, uniqueness: true
    validates :location, length: { maximum: 50 }

    has_many :order

    # transform shopping cart pictures into an array of line items
    def to_builder
        Jbuilder.new do |picture|
        picture.price stripe_price_id
        picture.quantity 1
        end
    end

end
