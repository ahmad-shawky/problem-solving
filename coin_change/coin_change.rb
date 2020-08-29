require 'minitest/autorun'

class CoinChange

  def initialize(coins, amount)
    @coins = coins
    @amount = amount
    @dp = Array.new((@amount+1), (@amount+1))
    @dp[0] = 0
  end

  def min
    (1..@amount).each do |sub_amount|
      @coins.each do |coin|
        if coin_can_exchange?(coin, sub_amount)
          set_sub_amount_minimum(coin, sub_amount)
        end
      end
    end
    find_minimum
  end

  private

  def coin_can_exchange?(coin, sub_amount)
    coin <= sub_amount
  end

  def set_sub_amount_minimum(coin, sub_amount)
    @dp[sub_amount] = [@dp[sub_amount], (1 + @dp[sub_amount-coin])].min
  end

  def find_minimum
    @dp[@amount] > @amount ? -1 : @dp[@amount]
  end
end


describe CoinChange do

  it "should return 0 for  amount: 0" do
    coin_change = CoinChange.new([1,5,6], 0)

    assert_equal 0, coin_change.min
  end

  it "should return -1 for  amount: 3, coins: [2]" do
    coin_change = CoinChange.new([2], 3)

    assert_equal -1, coin_change.min
  end

  it "should return 1 for  amount: 1, coins: [1]" do
    coin_change = CoinChange.new([1], 1)

    assert_equal 1, coin_change.min
  end

  it "should return 0 for  amount: 11, coins: [12]" do
    coin_change = CoinChange.new([12], 11)

    assert_equal -1, coin_change.min
  end

  it "should return 3 for  amount: 11, coins: [1, 3, 5]" do
    coin_change = CoinChange.new([1, 2, 5], 11)

    assert_equal 3, coin_change.min
  end
end
