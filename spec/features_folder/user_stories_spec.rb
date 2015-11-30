# In order to use public transport
# As a customer
# I want money on my card

require 'oystercard'







describe 'User Stories' do
  oystercard = Oystercard.new
  #balance = Balance.new


  it 'responds to balance' do
  expect { oystercard.balance }.not_to raise_error
  end

end