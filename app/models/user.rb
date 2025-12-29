# class User < ApplicationRecord
#   has_secure_password
#   validates :email, presence: true, uniqueness: true
# end

class User < ApplicationRecord
  has_secure_password

  enum :role, { consumer: 0, partner: 1, admin: 2 }

  validates :email, presence: true, uniqueness: true
end