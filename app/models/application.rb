class Application < ApplicationRecord
    belongs_to :user
    extend FriendlyId
    friendly_id :title, use: :slugged
    has_many :events
    validates :title, presence: true, uniqueness: true
    validates :url, presence: true, uniqueness: true
end
