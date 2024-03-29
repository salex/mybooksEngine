require "test_helper"

module Mybooks
  class BooksControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @book = mybooks_books(:one)
    end

    test "should get index" do
      get books_url
      assert_response :success
    end

    test "should get new" do
      get new_book_url
      assert_response :success
    end

    test "should create book" do
      assert_difference("Book.count") do
        post books_url, params: { book: { assets: @book.assets, checking: @book.checking, equity: @book.equity, expenses: @book.expenses, income: @book.income, liabilities: @book.liabilities, name: @book.name, root: @book.root, savings: @book.savings, settings: @book.settings } }
      end

      assert_redirected_to book_url(Book.last)
    end

    test "should show book" do
      get book_url(@book)
      assert_response :success
    end

    test "should get edit" do
      get edit_book_url(@book)
      assert_response :success
    end

    test "should update book" do
      patch book_url(@book), params: { book: { assets: @book.assets, checking: @book.checking, equity: @book.equity, expenses: @book.expenses, income: @book.income, liabilities: @book.liabilities, name: @book.name, root: @book.root, savings: @book.savings, settings: @book.settings } }
      assert_redirected_to book_url(@book)
    end

    test "should destroy book" do
      assert_difference("Book.count", -1) do
        delete book_url(@book)
      end

      assert_redirected_to books_url
    end
  end
end
