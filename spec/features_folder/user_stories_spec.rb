# In order to use public transport
# As a customer
# I want money on my card

# In order to keep using public transport
# As a customer
# I want to add money to my card

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card

# In order to get through the barriers.
# As a customer
# I need to touch in and out.

# In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.

# In order to pay for my journey
# As a customer
# When my journey is complete, I need the correct amount deducted from my card

require 'oystercard'

describe 'User Stories' do
  oystercard = Oystercard.new
  it 'responds to balance' do
  expect { oystercard.balance }.not_to raise_error
  end

  oystercard = Oystercard.new
  it 'adds money to oystercard' do
  expect { oystercard.top_up(1) }.not_to raise_error
  end

end
