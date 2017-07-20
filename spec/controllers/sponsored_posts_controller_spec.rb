require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsored_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10) }

    describe "GET show" do
      it "returns http success" do
        get :show, topic_id: my_topic.id, id: my_sponsored_post.id
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, topic_id: my_topic.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, topic_id: my_topic.id
        expect(response).to render_template :new
      end

      it "instantiates @sponsoredpost" do
        get :new, topic_id: my_topic.id
        expect(assigns(:sponsoredpost)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increase the number of SponsoredPost by 1" do
        expect{post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(SponsoredPost,:count).by(1)
      end

      it "assigns the new post to @sponsoredpost" do
        post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:sponsoredpost)).to eq SponsoredPost.last
      end

      it "redirects to the new sponsored post" do
        post :create, topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to [my_topic, SponsoredPost.last]
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
        expect(response).to have_http_status(:success)
      end

      it "renders the edit view" do
        get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
        expect(response).to render_template :edit
      end

      it "assigns sponsored post to be updated to @sponsoredpost" do
        get :edit, topic_id: my_topic.id, id: my_sponsored_post.id

        sponsoredpost_instance = assigns(:sponsoredpost)

        expect(sponsoredpost_instance.id).to eq my_sponsored_post.id
        expect(sponsoredpost_instance.title).to eq my_sponsored_post.title
        expect(sponsoredpost_instance.body).to eq my_sponsored_post.body
      end
    end

    describe "GET destroy" do
      it "deletes the post" do
        delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
        count = Post.where({id: my_sponsored_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
        expect(response).to redirect_to my_topic
      end
    end
  end
