require 'rails_helper'

describe 'Posts', type: :request do
  let(:valid_params) {
    {
      'post' =>
        {
          'title' => 'post title',
          'description' => 'post description',
          'privacy' => 'private'
        }
    }
  }
  let(:invalid_params) {
    {
      'post' =>
        {
          'title' => nil,
          'description' => nil,
          'privacy' => 'private'
        }
    }
  }

  describe 'GET /index' do
    it 'returns status code 200' do
      get posts_url
      expect(response).to be_successful
    end
  end
  describe 'GET /posts/new' do
    it 'return status code 200' do
      get new_post_url
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /posts create post' do
    it 'return status code 200' do
      post posts_url, params: valid_params
      expect(response).to redirect_to posts_path
      post = Post.first
      expect(post.title).to eq "post title"
      expect(post.description).to eq "post description"
      expect(post.privacy).to eq "private"
    end
    it 'return status code 422' do
      post posts_url, params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end
  describe 'GET /posts/1/edit' do
    it 'return status code 200' do
      post = Post.create(title: 'title', description: 'description', privacy: 'public')
      get edit_post_url(post)
      expect(response).to be_successful
    end
  end
  describe 'PATCH /posts/1' do
    it 'return status code 200' do
      post = Post.create(title: 'title', description: 'description', privacy: 'public')
      patch post_url(post), params: valid_params
      expect(response).to redirect_to posts_path
      post = Post.first
      expect(post.title).to eq 'post title'
    end
    it 'return status code 422' do
      post = Post.create(title: 'title', description: 'description', privacy: 'public')
      patch post_url(post), params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end
  describe 'DELETE /posts/1' do
    it 'return status code 200' do
      post = Post.create(title: 'title', description: 'description', privacy: 'public')
      delete "/posts/#{post.id}"
      expect(response).to redirect_to posts_path
    end
  end
end
