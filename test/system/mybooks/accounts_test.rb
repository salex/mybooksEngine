require "application_system_test_case"

module Mybooks
  class AccountsTest < ApplicationSystemTestCase
    setup do
      @account = mybooks_accounts(:one)
    end

    test "visiting the index" do
      visit accounts_url
      assert_selector "h1", text: "Accounts"
    end

    test "should create account" do
      visit accounts_url
      click_on "New account"

      fill_in "Account type", with: @account.account_type
      fill_in "Book", with: @account.book_id
      fill_in "Code", with: @account.code
      check "Contra" if @account.contra
      fill_in "Description", with: @account.description
      fill_in "Level", with: @account.level
      fill_in "Name", with: @account.name
      fill_in "Parent", with: @account.parent_id
      check "Placeholder" if @account.placeholder
      fill_in "Uuid", with: @account.uuid
      click_on "Create Account"

      assert_text "Account was successfully created"
      click_on "Back"
    end

    test "should update Account" do
      visit account_url(@account)
      click_on "Edit this account", match: :first

      fill_in "Account type", with: @account.account_type
      fill_in "Book", with: @account.book_id
      fill_in "Code", with: @account.code
      check "Contra" if @account.contra
      fill_in "Description", with: @account.description
      fill_in "Level", with: @account.level
      fill_in "Name", with: @account.name
      fill_in "Parent", with: @account.parent_id
      check "Placeholder" if @account.placeholder
      fill_in "Uuid", with: @account.uuid
      click_on "Update Account"

      assert_text "Account was successfully updated"
      click_on "Back"
    end

    test "should destroy Account" do
      visit account_url(@account)
      click_on "Destroy this account", match: :first

      assert_text "Account was successfully destroyed"
    end
  end
end
