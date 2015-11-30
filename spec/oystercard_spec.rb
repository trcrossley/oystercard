require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
end

# /Users/tristancrossley/Documents/oystercard/spec/oystercard_spec.rb:1:in `<top (required)>': uninitialized constant Oystercard (NameError)