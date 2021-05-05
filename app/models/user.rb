class User < ApplicationRecord
	acts_as_voter
	has_secure_password

	enum role: [:recruiter, :jobseeker]
	has_many :posts, dependent: :destroy
	validates :name, presence: true, length: { minimum: 3 }
	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
	validates :password, presence: true, on: :create;
	validates :role, presence: true, on: :create;
	validates_confirmation_of :password, on: :create;

end
