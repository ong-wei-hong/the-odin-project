def caesar_cipher (string, x)
    string.split('').map! do |c|
        if(c.ord >= 65 && c.ord <= 90)
            ((c.ord - 65 + x) % 26 + 65).chr
        elsif(c.ord >= 97 && c.ord <= 122)
            ((c.ord - 97 + x) % 26 + 97).chr
        else
            c
        end
    end.join('')
end
