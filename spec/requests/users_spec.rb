require 'rails_helper'

describe 'Users', type: :request do
  let(:valid_params) {
    {
      'user' =>
        {
          'name' => 'Mg Mg',
          'email' => 'mgmg@gmail.com',
          'password' => '123456',
          'password_confirmation' => '123456',
          'phone' => '09987654321',
          'address' => 'Pyay',
          'birthday' => '2023-03-07',
          'role' => 'user'
        }
    }
  }
  let(:invalid_params) {
    {
      'user' =>
        {
          'name' => nil,
          'email' => 'mgmg@gmail.com',
          'password' => '123456',
          'password_confirmation' => '654321',
          'phone' => '09987654321',
          'address' => 'Pyay',
          'birthday' => '2023-03-07',
          'role' => 'user'
        }
    }
  }
  describe 'GET /index' do
    it 'returns status code 200' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /users/new' do
    it 'return status code 200' do
      get '/users/new'
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /users' do
    it 'return status code 200' do
      post '/users', params: valid_params
      expect(response).to redirect_to root_path
      user = User.last
      expect(user.name).to eq 'Mg Mg'
      expect(user.email).to eq 'mgmg@gmail.com'
      expect(user.phone).to eq '09987654321'
      expect(user.role).to eq 'user'
    end
    it 'return status code 422' do
      post '/users', params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end
  describe 'GET /users/1/edit' do
    it 'return status code 200' do
      get edit_user_url(User.first)
      expect(response).to be_successful
    end
  end
  describe 'PATCH /users/1' do
    it 'return status code 200' do
      patch user_url(User.first), params: valid_params
      expect(response).to redirect_to root_path
      user = User.first
      expect(user.name).to eq 'Mg Mg'
    end
    it 'return status code 422' do
      patch user_url(User.first), params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end
  describe 'DELETE /users/1' do
    it 'return status code 200' do
      delete "/users/#{User.first.id}"
      expect(response).to redirect_to root_path
    end
  end
  describe 'GET /profile' do
    it 'return status code 200' do
      get "/profile/#{User.first.id}"
      expect(response).to be_successful
    end
  end
  describe 'POST /users/import' do
    it 'return status code 200' do
      file = Rack::Test::UploadedFile.new('app/assets/users.csv','text/csv')
      post '/users/import', :params => { file: file }
      expect(response).to redirect_to root_path
    end
    it 'return status code 422' do
      post '/users/import'
      expect(flash[:file]).to eq('File field is required')
    end
    it 'return file type error' do
      file =  Rack::Test::UploadedFile.new('app/assets/images/cat.png','image/png')
      post '/users/import', :params => { file: file }
      expect(flash[:file]).to eq('File type must be: text/csv')
    end
  end
end
