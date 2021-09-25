class ApplicationController < ActionController::Base
    include SessionsHelper

    before_action :initialize_cart
    before_action :load_cart

    private

    def initialize_cart
        session[:cart] ||= [] # empty cart = empty array
    end

    def load_cart
        # @cart = Product.find(session[:cart])
        # Product.all.pluck(:id) => 1, 2
        # Product.find(1, 2, 3) => error
        # Product.where(id: [1, 2, 3]) => 1, 2
        @cart = Product.where(id: session[:cart])
    end
end
