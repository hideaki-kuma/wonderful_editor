class Api::V1::BaseApiController < ApplicationController
  def current_user
    @current_user ||= User.first
    # 模範解答を参照
    # @current_userがnilの場合にUser.firstの値を代入する
  end
end
