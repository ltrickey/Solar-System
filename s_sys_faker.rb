require 'faker'

class Planet
  attr_reader :name, :diameter, :mass, :moons, :type, :distance_from_sun, :period_of_revolution

  def initialize(planet_hash)
    @name = planet_hash[:name]
    @diameter = planet_hash[:diameter]
    @mass = planet_hash[:mass]
    @moons = planet_hash[:moons]
    @type = planet_hash[:type]
    @distance_from_sun = planet_hash[:distance_from_sun]
    @period_of_revolution = planet_hash[:period_of_revolution]
  end

  def print_info
    "#{ @name.capitalize }:
    Number of moons: #{ @moons }
    Diameter: #{ @diameter } miles
    Mass: #{ @mass }
    Type: #{ @type }
    Distance from Sun: #{ @distance_from_sun } Million Miles
    1 revolution around the Sun: #{ @period_of_revolution } Earth Years"
  end

end

class Solar_System
  attr_accessor :number_of_planets, :moons, :planets
  attr_reader :age, :name

  def initialize(list_of_planets, age, name)
    @number_of_planets = list_of_planets.length
    @planets = list_of_planets
    @age = age
    @name = name
  end

  def add_planets(additional_planets)
    additional_planets.each do |planet|
      if planet.class == Planet
        @planets << planet
        @number_of_planets += 1
      end
    end
  end

  def print_info
    @planets.each do |planet|
      puts planet.print_info
    end
  end

  def distance_between_planets(first_planet, second_planet)
    if (first_planet.distance_from_sun - second_planet.distance_from_sun) > 0
      "#{ first_planet.name.capitalize } is #{ first_planet.distance_from_sun - second_planet.distance_from_sun } million miles away from #{ second_planet.name.capitalize }"
    else
      "#{ first_planet.name.capitalize } is #{ second_planet.distance_from_sun - first_planet.distance_from_sun } million miles away from #{ second_planet.name.capitalize }"
    end
  end

  #method to find local year of planet
  #supposing all planets were created
  #at same time universe was created
  def local_year(planet)
      if planet.class == Planet
        planet_year = planet.period_of_revolution * @age
        @local_year = planet_year.to_i
        "On the planet #{ planet.name.capitalize } the year is #{ @local_year }."
      end
  end

end

planets_in_solar_system = []

planet_number = rand(2..25)
(planet_number).times do
  #create a new hash with info
  new_hash = {
    name: (Faker::Name.first_name),
    moons: (Faker::Number.between(0, 100)),
    diameter: (Faker::Number.positive).round(2),
    mass: ("#{ Faker::Number.decimal(1, 2) } x 10^#{ Faker::Number.number(2) }"),
    type: (Faker::Food.ingredient),
    distance_from_sun: (Faker::Number.between(20, 10000)),
    period_of_revolution: (Faker::Number.between(1, 1000))
  }
    planets_in_solar_system << Planet.new(new_hash)
end

new_system = Solar_System.new(planets_in_solar_system, Faker::Number.between(10, 9999999999), Faker::LordOfTheRings.location)

puts "Welcome to the #{ new_system.name } Solar System!"
#promts user to enter a planet
puts "Here are some fun facts about #{ new_system.name }"
puts "There are #{ planet_number } planets in this system: "
#lists all planets
number = 1
planets_in_solar_system.each do |planet|
  puts "#{number}. #{planet.name.capitalize}"
  number += 1
end
puts new_system.distance_between_planets(planets_in_solar_system[0], planets_in_solar_system[1])

puts new_system.local_year(planets_in_solar_system[-1])

# prints out planet info until user wants to stop
while true
  puts "\nWould you like to learn more about a specific planet? Y/N?"
  learn_more = gets.chomp.downcase
    if learn_more == "yes" || learn_more == "y"
      puts "Great!  What other planet would you like to learn about?"
      planet_choice = gets.chomp.downcase
    else
      break
    end
  planets_in_solar_system.each do |planet|
    if planet.name.downcase == planet_choice
      puts planet.print_info
    end
  end
end
