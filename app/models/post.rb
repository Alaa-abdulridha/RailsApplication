class Post < ApplicationRecord
	acts_as_votable
	enum status: [:available, :expired]
	belongs_to :user
	validates :name, presence: true, length: { minimum: 3 }
	validates :description, presence: true
	validates :date, presence: true, on: :create;
	validates :address, presence: true
	validates :city, presence: true, on: :create;
	validates :state, presence: true, on: :create;
	validates :country, presence: true, on: :create;
	validates :zipcode, presence: true, on: :create;
	
end
