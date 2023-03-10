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
      user = User.first
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
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end
  describe 'PATCH /users/1' do
    it 'return status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      patch user_url(user), params: valid_params
      expect(response).to redirect_to root_path
      user = User.first
      expect(user.name).to eq 'Mg Mg'
    end
    it 'return status code 422' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      patch user_url(user), params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end
  describe 'DELETE /users/1' do
    it 'return status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      delete "/users/#{user.id}"
      expect(response).to redirect_to root_path
    end
  end
  describe 'GET /profile' do
    it 'return status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      get "/profile/#{user.id}"
      expect(response).to be_successful
    end
  end
end
