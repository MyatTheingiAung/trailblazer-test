require 'rails_helper'

describe 'Login', type: :request do
  let(:valid_params) {
    {
      'user' =>
        {
          'email' => 'mama@gmail.com',
          'password' => '123456'
        }
    }
  }
  let(:invalid_params) {
    {
      'user' =>
        {
          'email' => '',
          'password' => '123456'
        }
    }
  }
  let(:pass_params) {
    {
      'user' =>
        {
          'email' => 'mama@gmail.com'
        }
    }
  }
  describe 'GET /users/sign_in' do
    it 'returns status code 200' do
      get new_user_session_url
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /users/sign_in' do
    it 'returns status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      post user_session_url, params: valid_params
      expect(response).to redirect_to root_path
    end
    it 'returns status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      post user_session_url, params: invalid_params
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end
  describe 'GET /users/password/new' do
    it 'returns status code 200' do
      get new_user_password_url
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /users/password' do
    it 'returns status code 200' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      post user_password_url, params: pass_params
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'returns status code 422' do
      user = User.create(name: 'ma ma', email: 'mama@gmail.com', password: '123456', password_confirmation: '123456', phone: '09987654321', address: 'pyay', birthday: '2023-03-07', role: 'user')
      post user_password_url
      expect(response).to render_template(:new)
    end
  end
end
