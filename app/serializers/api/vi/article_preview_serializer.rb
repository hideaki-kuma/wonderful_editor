class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at
end
# 記事一覧で返してほしいjsonの値
