class User < ApplicationRecord

    has_many :order
    attr_accessor :remember_token

    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 250 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? 
        BCrypt::Engine::MIN_COST :
                                                      
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def self.authenticate(user_info)
        find_by_username_and_password(user_info[:email], user_info[:password])
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, 
        User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?
        (remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    after_create do
        customer = Stripe::Customer.create(email: :email)
        update(stripe_customer_id: user.id)
    end

end
