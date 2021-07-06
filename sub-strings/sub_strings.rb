def substrings (string, dictionary)
    string.downcase!
    dictionary.reduce(Hash.new(0)) do |hash, word|
        x = string.scan(/(?=#{word})/).count
        x > 0 && hash[word] = x
        hash
    end
end