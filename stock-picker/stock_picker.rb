def stock_picker(prices)
    days = [0, 0]
    max_profit = 0
    min_price = prices[0]
    min_day = 0

    prices.each_with_index do |price, day|
        if price < min_price
            min_price = price
            min_day = day
            next
        end

        if price - min_price > max_profit
            max_profit = price - min_price
            days = [min_day, day]
        end
    end    
    days    
end