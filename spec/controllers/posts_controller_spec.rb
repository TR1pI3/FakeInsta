require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { create(:user) }
  let!(:new_post) { create(:post, user:) }

  before { sign_in user }

  describe 'GET /posts' do
    before { get posts_path }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders correct content of the posts' do
      expect(response.body).to include(new_post.body)
      expect(response.body).to include(new_post.image.url)
    end
  end

  describe 'GET /posts/:id' do
    before { get posts_path(new_post) }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the post details' do
      expect(response.body).to include(new_post.body)
      expect(response.body).to include(new_post.image.url)
    end
  end

  describe 'GET /posts/new' do
    before { get new_post_path }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the new post form' do
      expect(response.body).to include('form')
    end
  end

  describe 'POST /posts' do
    subject { post posts_path, params: }
    context 'with valid parameters' do
      let(:params) { { post: { body: 'Valid body', image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/image.png'))) } } }
      it 'creates a new post' do
        expect { subject }.to change(Post, :count).by(1)
      end

      it 'redirects to the index page with a notice' do
        post(posts_path, params:)
        expect(response).to redirect_to(posts_path)
        follow_redirect!
        expect(response.body).to include('Post was successfully created')
      end
    end

    context 'with invalid parameters' do
      let(:params) { { post: { body: '', image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/image.png'))) } } }
      it 'does not create a post' do
        expect { post(posts_path, params:) }.not_to change(Post, :count)
      end

      it 're-renders the new form' do
        post(posts_path, params:)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /posts/:id/edit' do
    before { get edit_post_path(new_post) }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the edit form' do
      expect(response.body).to include('form')
      expect(response.body).to include(new_post.body)
    end
  end

  describe 'PATCH /posts/:id' do
    context 'with valid parameters' do
      let(:new_body) { 'Updated post body' }
      before { patch post_path(new_post), params: { post: { body: new_body } } }

      it 'updates the post' do
        expect(new_post.reload.body).to eq(new_body)
      end

      it 'redirects to the index page with a notice' do
        expect(response).to redirect_to(posts_path)
        follow_redirect!
        expect(response.body).to include('Post was successfully updated')
      end
    end

    context 'with invalid parameters' do
      before { patch post_path(new_post), params: { post: { body: '' } } }

      it 'does not update the post' do
        expect(new_post.reload.body).not_to eq('')
      end

      it 're-renders the edit form with an alert' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    let!(:delete_post) { create(:post, user:) }
    it 'deletes the post' do
      expect { delete post_path(delete_post) }.to change(Post, :count).by(-1)
    end

    it 'redirects to the index page with a notice' do
      delete post_path(delete_post)
    end
  end
end
