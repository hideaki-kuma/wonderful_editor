# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  # アソシエーション
  belongs_to :user, optional: true
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
end
