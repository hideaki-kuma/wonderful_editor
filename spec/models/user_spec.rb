# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string           not null
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "name を指定しているとき" do
    it "ユーザーが作られる" do
      aggregate_failures do
        user = build(:user)
        expect(user.valid?).to eq true
      end
    end
  end

  context "name を指定していないとき" do
    it "ユーザー作成に失敗する" do
      aggregate_failures do
        user = build(:user, name: nil)
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("can't be blank")
      end
    end
  end

  context "nameの文字数が３文字以下の場合" do
    it "ユーザー作成に失敗する" do
      aggregate_failures do
        user = build(:user, name: "ann")
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("is too short (minimum is 4 characters)")
      end
    end
  end

  context "nameの文字数11文字以上の場合" do
    it "ユーザー作成に失敗する" do
      aggregate_failures do
        user = build(:user, name: "xxxxxxxxxxx")
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("is too long (maximum is 10 characters)")
      end
    end
  end

  context "すでに同じname が存在しているとき" do
    before { create(:user, name: "taro") }
    it "ユーザー作成に失敗する" do
      aggregate_failures do
        user = build(:user, name: "taro")
        expect(user).to be_invalid
        expect(user.errors[:name]).to include("has already been taken")
      end
    end
  end
end
