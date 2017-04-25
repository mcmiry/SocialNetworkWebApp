class User < ApplicationRecord
    has_many :post
    has_many :relationship
    has_many :share
end
