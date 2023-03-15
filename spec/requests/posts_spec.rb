require 'rails_helper'

describe 'Posts', type: :request do
  let(:valid_params) {
    {
      'post' =>
        {
          'title' => 'post title',
          'description' => 'post description',
          'privacy' => 'private',
          'user_id' => current_user.id
        }
    }
  }
  let(:invalid_params) {
    {
      'post' =>
        {
          'title' => nil,
          'description' => nil,
          'privacy' => 'private',
          'user_id' => current_user.id
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
      post = Post.last
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
      get edit_post_url(Post.first)
      if current_user.id == Post.first.user_id
        expect(response).to be_successful
      else
        expect(response).to have_http_status(404)
      end
    end
  end
  describe 'PATCH /posts/1' do
    it 'return status code 200' do
      patch post_url(Post.first), params: valid_params
      expect(response).to redirect_to posts_path
      post = Post.first
      expect(post.title).to eq 'post title'
    end
    it 'return status code 422' do
      patch post_url(Post.first), params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end
  describe 'DELETE /posts/1' do
    it 'return status code 200' do
      delete "/posts/#{Post.first.id}"
      expect(response).to redirect_to posts_path
    end
  end
  describe 'POST /posts/import' do
    it 'return status code 200' do
      file = Rack::Test::UploadedFile.new('app/assets/posts.csv','text/csv')
      post '/posts/import', :params => { file: file }
      expect(response).to redirect_to posts_path
    end
    it 'return status code 422' do
      post '/posts/import'
      expect(flash[:file]).to eq('File field is required')
    end
    it 'return file type error' do
      file =  Rack::Test::UploadedFile.new('app/assets/images/cat.png','image/png')
      post '/posts/import', :params => { file: file }
      expect(flash[:file]).to eq('File type must be: text/csv')
    end
  end
  describe 'GET /posts/copy/1' do
    it 'return status code 200' do
      get "/posts/copy/#{Post.first.id}"
      expect(response).to be_successful
    end
  end
  describe 'POST /posts/copy' do
    it 'return status code 200' do
      post posts_copy_url(Post.first), params: valid_params
      expect(response).to redirect_to posts_path
      post = Post.last
      expect(post.title).to eq 'post title'
      expect(post.description).to eq 'post description'
      expect(post.privacy).to eq 'private'
    end
    it 'return status code 422' do
      post posts_copy_url(Post.first), params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:copy_form)
    end
  end
end
