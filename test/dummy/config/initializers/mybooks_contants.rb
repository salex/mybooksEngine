# try to put constants here

ACCT_TYPES =  %w{ASSET BANK CASH CREDIT EQUITY EXPENSE INCOME LIABILITY PAYABLE RECEIVABLE ROOT}.freeze

ROOT_ACCOUNTS = %w{ROOT ASSET LIABILITY EQUITY INCOME EXPENSE}

Dummy::Application.config.x.acct_updated = Time.now.utc.to_s
