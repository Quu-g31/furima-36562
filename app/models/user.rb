class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :item
  has_many :purchase_log

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  with_options presence: true do
    with_options format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}]+\z/ } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
  validates :birth_day, presence: true
end
