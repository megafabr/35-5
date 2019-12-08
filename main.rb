# Для подключения всех необходимых gems установите bundler (gem install bundler)

require 'oga'
require 'open-uri'
require_relative 'lib/film'
require_relative 'lib/film_collection'


puts 'Программа "Фильм на вечер"'

films = FilmCollection.films_used_oga

directors = films.directors

directors_list = films.directors_list

puts directors_list.join("\n")
puts
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"

user_input = gets.to_i
until (1..directors.size).include?(user_input) do
  puts "Такого режиссера нет в списке! Повторите ввод еще раз"
  user_input = gets.to_i
end

chosen_director = directors[user_input - 1]
puts chosen_director

puts "Сегодня вечером рекомендую посмотреть:"

puts films.film_today(chosen_director)