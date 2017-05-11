class User < ApplicationRecord
    has_many :post
    has_many :relationship
    has_many :share

    validates :name, presence: true
    validates :surname, presence: true
    validates :nick, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :email, uniqueness: true
    validates :nick, uniqueness: true
end
