class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chats, dependent: :destroy

  def self.guest
   find_or_create_by!(email: 'aaa@aaa.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.password_confirmation = user.password
    user.name = '空野花子'
  end
  end
end
