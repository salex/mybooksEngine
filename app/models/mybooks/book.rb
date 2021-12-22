module Mybooks
  class Book < ApplicationRecord
    has_many :accounts, dependent: :destroy
    has_many :entries, dependent: :destroy
    has_many :bank_statements, dependent: :destroy
    has_many :ofxes

    serialize :settings, HashWithIndifferentAccess
    attribute :recent


    def build_tree
      new_tree = []
      troot = self.accounts.find_by(uuid:self.root)
      troot.walk_tree(0,new_tree)
      new_tree.each do |a| 
        if a.level_changed?
          a.save
        end
      end
      new_tree
    end

    def destroy_book
      self.entries.destroy_all
      # self.bank_statements.destroy_all
      self.accounts.destroy_all
      self.destroy
    end


    def root_acct
      self.accounts.find_by(uuid:self.root)
    end

    def checking_acct
      self.accounts.find_by(uuid:self.checking)
    end

    def assets_acct
      self.accounts.find_by(uuid:self.assets)
    end

    def liabilities_acct
      self.accounts.find_by(uuid:self.liabilities)
    end

    def equity_acct
      self.accounts.find_by(uuid:self.equity)
    end

    def income_acct
      self.accounts.find_by(uuid:self.income)
    end

    def expenses_acct
      self.accounts.find_by(uuid:self.expenses)
    end

    def savings_acct
      self.accounts.find_by(uuid:self.savings)
    end

    def current_assets
      self.accounts.find_by(name:'Current')
    end



    def get_settings
      return {}.with_indifferent_access if self.settings[:skip].present? # on create new book
      reset = (Rails.application.config.x.acct_updated > self.updated_at.to_s || self.settings.blank?)
      # puts "DEBUG conf #{Rails.application.config.x.acct_updated}"
      # puts "DEBUG at #{self.updated_at.to_s}"
      # puts "DEBUG blank #{self.settings.blank?}"
      # puts "DEBUG reset #{reset}"

      if reset
        checking = checking_acct
        new_settings = {}.with_indifferent_access
        accts = build_tree
        id_trans = accts.pluck(:id,:transfer)
        if checking.present?
          new_settings[:checking_acct_id] = checking.id 
          new_settings[:checking_ids] = checking.leaf
        end
        new_settings[:transfers] = id_trans.to_h
        new_settings[:tree_ids] = new_settings[:transfers].keys
        new_settings[:acct_sel_opt] = id_trans.map{|i| i.reverse}.prepend(['',0])
        new_settings[:dis_opt] = accts.select{|a| a.placeholder}.pluck(:id)
        new_settings[:acct_sel_opt_rev] = new_settings[:acct_sel_opt].
          select{|i| i  unless new_settings[:dis_opt].include?(i[1])}.
          map{|i|[ i[0].split(':').reverse.join(':'),i[1]]}.
          sort_by { |word| word[0].downcase }
        self.settings = new_settings
        self.touch
        self.save!
      end
      return self.settings
    end
  end

  def self.create_book
    book = Book.new
    book.root = SecureRandom.uuid
    book.assets = SecureRandom.uuid
    book.liabilities = SecureRandom.uuid
    book.equity = SecureRandom.uuid
    book.income = SecureRandom.uuid
    book.expenses = SecureRandom.uuid
    book.checking = SecureRandom.uuid
    book.savings = SecureRandom.uuid
    settings = {skip:true}
    book.save


    broot = book.accounts.create(  
      {:name=>"Root Account",
       :account_type=>"ROOT",
       :description=>"",
       :parent_id=>nil,
       :placeholder=>true,
       :level=>0,
       :uuid=>book.root
    })

    bassets = book.accounts.create(
      {:name=>"Assets",
      :account_type=>"ASSET",
      :description=>"",
      :parent_id=>broot.id,
      :placeholder=>true,
      :level=>1,
      :uuid=>book.assets
      })

    bliabilities = book.accounts.create(
      {:name=>"Liabilities",
      :account_type=>"LIABILITY",
      :description=>"",
      :parent_id=>broot.id,
      :placeholder=>true,
      :level=>1,
      :uuid=>book.liabilities
    })

    bequity = book.accounts.create(
      {:name=>"Equity",
      :account_type=>"EQUITY",
      :description=>"",
      :parent_id=>broot.id,
      :placeholder=>true,
      :level=>1,
      :uuid=>book.equity
    })

    bincome = book.accounts.create(
      {:name=>"Income",
      :account_type=>"INCOME",
      :description=>"",
      :parent_id=>broot.id,
      :placeholder=>true,
      :level=>1,
      :uuid=>book.income
    })

    bexpense = book.accounts.create(
      {:name=>"Expenses",
      :account_type=>"EXPENSE",
      :description=>"",
      :parent_id=>broot.id,
      :placeholder=>true,
      :level=>1,
      :uuid=>book.expenses
    })

    bchecking = book.accounts.create(
      {:name=>"Checking",
      :account_type=>"BANK",
      :description=>"",
      :parent_id=>bassets.id,
      :placeholder=>false,
      :level=>2,
      :uuid=>book.checking
    })

    bsaving = book.accounts.create(
      {:name=>"Savings",
      :account_type=>"BANK",
      :description=>"",
      :parent_id=>bassets.id,
      :placeholder=>false,
      :level=>2,
      :uuid=>book.savings
    })
    self.settings = {}
    self.save
    self.get_settings
    true

  end
end
