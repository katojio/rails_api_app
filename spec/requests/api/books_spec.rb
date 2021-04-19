# frozen_string_literal: true

require 'rails_helper'

describe 'GET /api/books' do
  before do
    create_list(:book, 3)
  end

  it 'gets all books' do
    get '/api/books'
    json = JSON.parse(response.body)

    expect(response).to have_http_status :ok
    expect(json.dig('data').length).to eq 3
  end
end

describe 'GET /api/books/:id' do
  let!(:book) { create(:book) }

  it 'gets the book' do
    get "/api/books/#{book.id}"
    json = JSON.parse(response.body)

    expect(response).to have_http_status :ok
    expect(json.dig('data', 'title')).to eq book.title
    expect(json.dig('data', 'author')).to eq book.author
  end
end

describe 'POST /api/books' do
  let(:params) { { 'book': { 'title': '何かタイトル', 'author': 'どこかの著者' } } }

  it 'creates the book' do
    post '/api/books', params: params
    json = JSON.parse(response.body)

    expect(response).to have_http_status :created
    expect(json.dig('data', 'title')).to eq '何かタイトル'
    expect(json.dig('data', 'author')).to eq 'どこかの著者'
  end
end

describe 'PUT /api/books/:id' do
  let!(:book) { create(:book) }
  let(:params) { { 'book': { 'title': '何かタイトル', 'author': 'どこかの著者' } } }

  it 'updates the book' do
    put "/api/books/#{book.id}", params: params
    json = JSON.parse(response.body)

    expect(response).to have_http_status :created
    expect(json.dig('data', 'title')).to eq '何かタイトル'
    expect(json.dig('data', 'author')).to eq 'どこかの著者'
  end
end

describe 'DELETE /api/books/:id' do
  let!(:book) { create(:book) }

  it 'deletes the book' do
    delete "/api/books/#{book.id}"
    json = JSON.parse(response.body)

    expect(response).to have_http_status :ok
    expect(json.dig('data', 'title')).to eq book.title
    expect(json.dig('data', 'author')).to eq book.author
  end
end
