module Api::V1
  class ArticlesController < BaseApiController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    # GET /articles
    def index
      articles = Article.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    # GET /articles/1
    def show
      render json: article, each_serializer: Api::V1::ArticleSerializer
    end

    # GET /articles/new
    def new
      @article = Article.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles
    def create
      article = current_user.articles.create!(article_params)
      render json: article, each_serializer: Api::V1::ArticleSerializer
    end

    # PATCH/PUT /articles/1
    def update
      if @article.update(article_params)
        redirect_to @article, notice: "Article was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /articles/1
    def destroy
      @article.destroy!
      redirect_to articles_url, notice: "Article was successfully destroyed."
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def article_params
        # params.permit(:title, :body)
        params.require(:article).permit(:title, :body)
      end
  end
end
