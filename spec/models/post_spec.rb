require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:like) { create(:like, post:, user:) }
  let(:unliked_post) { create(:post, user:) }

  describe 'liked' do
    context 'when the user has liked the post' do
      it 'returns true' do
        expect(post.liked?(user)).to be true
      end
    end

    context 'when the user has not liked the post' do
      it 'returns false' do
        expect(unliked_post.liked?(user)).to be false
      end
    end
  end
end
