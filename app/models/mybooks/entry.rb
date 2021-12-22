module Mybooks
  class Entry < ApplicationRecord
    belongs_to :book
  end
end
