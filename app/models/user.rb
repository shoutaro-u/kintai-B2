class User < ApplicationRecord
# コールバックメソッド 保存される前に現在のメールアドレスの値を小文字にする。又、selfは現在のユーザーを指している
  before_save { self.email = email.downcase }
# nameカラムの存在性と最大文字数を検証
  validates :name, presence: true, length: { maximum: 50}
# メールアドレスのフォーマットを検証できる
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# emailカラムの存在性と最大文字数、フォーマット、一意性を検証(indexを追加してデータベースレベルでも一意性を強制する)
  validates :email, presence: true, length: { maximum: 100}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
# password_digestカラムとbcrpt gemを追加したことで使用可能になった
  has_secure_password
# パスワードの存在性と最小文字数の検証
  validates :password, presence: true, length: { minimum: 6 }
end