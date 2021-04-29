require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "Api::V1::Articles", type: :request do
  # Article. As you add validations to Article, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /articles" do
    # 記事一覧が取得できる
    # id タイトル 更新日の項目が取得できる
    subject { get(api_v1_articles_path) }

    # before { create_list(:article, 3) }
    let!(:article1) { create(:article, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, updated_at: 2.days.ago) }
    let!(:article3) { create(:article) }

    it "記事の一覧が取得できる" do
      subject
      binding.pry
      # aggregate_failures "最後まで通過" do
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET / articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の記事が存在するとき" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "その記事を取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"].keys).to eq ["id", "name", "email"]
        expect(res["updated_at"]).to be_present
      end
    end

    context "指定した id の記事が存在しないとき" do
      let(:article_id) { 100000 }
      it "その記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_article_url
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET /edit" do
  #   it "render a successful response" do
  #     article = Article.create! valid_attributes
  #     get edit_article_url(article)
  #     expect(response).to be_successful
  #   end
  # end

  describe "POST /articles" do
    subject { post(api_v1_articles_path, params: params) }

    let(:params) { { article:attributes_for(:article) } }
    let(:current_user) { create(:user) }

    context "適切なパラメータを送信したとき" do
     before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user)}
     binding.pry
      it "記事のレコードを作成できる" do
        expect { subject }.to change { Article.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["bod"]).to eq params[:article][:body]
        expect(response).to have_http_status(:ok)
      end
    end
      it "redirects to the created article" do
        post articles_url, params: { article: valid_attributes }
        expect(response).to redirect_to(article_url(Article.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Article" do
        expect {
          post articles_url, params: { article: invalid_attributes }
        }.to change { Article.count }.by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post articles_url, params: { article: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested article" do
  #       article = Article.create! valid_attributes
  #       patch article_url(article), params: { article: new_attributes }
  #       article.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the article" do
  #       article = Article.create! valid_attributes
  #       patch article_url(article), params: { article: new_attributes }
  #       article.reload
  #       expect(response).to redirect_to(article_url(article))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a successful response (i.e. to display the 'edit' template)" do
  #       article = Article.create! valid_attributes
  #       patch article_url(article), params: { article: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested article" do
  #     article = Article.create! valid_attributes
  #     expect {
  #       delete article_url(article)
  #     }.to change { Article.count }.by(-1)
  #   end

  #   it "redirects to the articles list" do
  #     article = Article.create! valid_attributes
  #     delete article_url(article)
  #     expect(response).to redirect_to(articles_url)
  #   end
  # end
  # end
end
