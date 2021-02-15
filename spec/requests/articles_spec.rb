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

RSpec.describe "/articles", type: :request do
  # Article. As you add validations to Article, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Article.create! valid_attributes
      get articles_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      article = Article.create! valid_attributes
      get article_url(article)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_article_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      article = Article.create! valid_attributes
      get edit_article_url(article)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Article" do
        expect {
          post articles_url, params: { article: valid_attributes }
        }.to change { Article.count }.by(1)
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

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested article" do
        article = Article.create! valid_attributes
        patch article_url(article), params: { article: new_attributes }
        article.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the article" do
        article = Article.create! valid_attributes
        patch article_url(article), params: { article: new_attributes }
        article.reload
        expect(response).to redirect_to(article_url(article))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        article = Article.create! valid_attributes
        patch article_url(article), params: { article: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested article" do
      article = Article.create! valid_attributes
      expect {
        delete article_url(article)
      }.to change { Article.count }.by(-1)
    end

    it "redirects to the articles list" do
      article = Article.create! valid_attributes
      delete article_url(article)
      expect(response).to redirect_to(articles_url)
    end
  end
end
