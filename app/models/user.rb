class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "PrivateMessage", foreign_key: "receiver_id", dependent: :destroy
end
