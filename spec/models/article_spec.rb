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
require "rails_helper"

RSpec.describe Article, type: :model do
  let(:user) { User.create!(name: "aaaa", email: "aaaa@example.com", password: "password") }
  context "title とbodyが入力されているとき" do
    let(:article) { Article.new(title: "今日の課題", body: "取り組んだこと", user_id: user.id) }

    it "記事が作成される" do
      expect(article).to be_valid
    end
  end
end
