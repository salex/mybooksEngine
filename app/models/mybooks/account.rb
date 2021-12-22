module Mybooks
  class Account < ApplicationRecord
    belongs_to :book
  end
end
