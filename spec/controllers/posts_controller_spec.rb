require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET /posts' do
    let!(:post) { create(:post, user: user) }
    before { get posts_path }
    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'render correct content of the posts' do
        expect(response.body).to include(post.body)
        expect(response.body).to include(post.image.url)
      end
    end
  end
