class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  validates :nickname, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX}
  with_options presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ]+\z/ } do
    validates :last_name
    validates :first_name
  end
  with_options presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end
  validates :birth_day, presence: true
end
