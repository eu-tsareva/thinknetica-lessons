alphabet = ('a'..'z').to_a
vowels = %w(a e i o u)

vowels_positions = vowels.map { |vowel| [vowel, alphabet.index(vowel) + 1] }.to_h
puts "Hash with vowel positions: #{vowels_positions}"
