# frozen_string_literal: true

module Api
  class BooksController < ApplicationController
    before_action :set_book, only: %i[show update destroy]

    def index
      books = Book.order(created_at: :desc)
      render json: { data: books }
    end

    def show
      render json: { data: @book }
    end

    def create
      book = Book.new(book_params)

      if book.save
        render json: { data: book }, status: :created
      else
        render json: { errors: book.errors }, status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        render json: { data: @book }, status: :created
      else
        render json: { errors: @book.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @book.destroy
        render json: { data: @book }
      else
        render json: { errors: @book.errors }, status: :unprocessable_entity
      end
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author)
    end
  end
end
