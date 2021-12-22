module Mybooks
  class Split < ApplicationRecord
    belongs_to :account
    belongs_to :entry
  end
end
