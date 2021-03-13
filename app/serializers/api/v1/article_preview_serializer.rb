class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at

  belongs_to :user, serializer: Api::V1::UserSerializer
  # ↑模範を参考に追加
end
# 記事一覧で返してほしいjsonの値
