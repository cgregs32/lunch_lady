# require_relative 'lunch_class'
require 'pry'
require 'colorize'

class MenuItems
  attr_reader = :item, :price, :calories

  def initialize(item, price, calories, index)
    @index = index
    @item = item
    @price = price
    @calories = calories
  end

  def display_items
      puts "[#{@index + 1}] #{@item.ljust(18)}  #{@price.to_s.ljust(13).colorize(:green)} #{@calories.to_s.colorize(:light_red)}"
  end
end

class Tray
  attr_accessor = :items, :total, :calories_total
  def initialize(items, total, calories)
    @items = items
    @total = total
    @calories_total = calories
  end

  def add_to_cart(item)
    @items << item
    @total += item[:price]
    @calories_total += item[:calories]
  end

  def invoice
    puts "---------Receipt-------------".colorize(:light_blue)
    @items.each_with_index do |each, i|
      puts "[#{i + 1}] #{each[:item].ljust(18)}  #{each[:price].to_s.ljust(13).colorize(:green)} #{each[:calories].to_s.colorize(:light_red)}"
    end
    puts "#{'Total'.ljust(24)}#{@total.round(2).to_s.colorize(:red)} #{''.ljust(8)} #{@calories_total.to_s.colorize(:red)}"
  end
end

class Customer
  def initialize(name, money)
    @name = name
    @money = money
  end

  def purchase_item

  end
end


def lunch_time
  puts "----------- Its Lunch Time! ------------".colorize(:blue)
  puts "Welcome to the Diner, what is your name"
  name = gets.chomp
  puts "Hi, #{name}, what can I get for you?"

  @custy = Customer.new(name, 50)

  puts "#{@custy.instance_variable_get(:@name)} has #{@custy.instance_variable_get(:@money)}$"


  @tray = Tray.new([], 0, 0)
  main_dish
end

def main_dish
  while true
    puts "#{''.ljust(4)}Item #{''.ljust(15)}Price #{''.ljust(8)}Calories"
    @entree_item.each_with_index do |item, i|
      entree = MenuItems.new(item[:item], item[:price], item[:calories], i)
      entree.display_items
    end
    puts "[5] To Continue"

    puts "---------Main Course---------".colorize(:blue)
    puts "What item would you like to add?"
    add_item = gets.strip.to_i

    case add_item
    when 1
      puts "You added #{@entree_item[0][:item]} to the cart"
      @tray.add_to_cart(@entree_item[0])
    when 2
      puts "You added #{@entree_item[1][:item]} to the cart"
      @tray.add_to_cart(@entree_item[1])
    when 3
      puts "You added #{@entree_item[2][:item]} to the cart"
      @tray.add_to_cart(@entree_item[2])
    when 4
      puts "You added #{@entree_item[3][:item]} to the cart"
      @tray.add_to_cart(@entree_item[3])
    when 5
      side_dish
    else
      puts "please enter valid input"
    end
    puts "Add another item"
  end

end


def side_dish
  while true
    @side_item.each_with_index do |item, i|
      side = MenuItems.new(item[:item], item[:price], item[:calories], i)
      side.display_items
    end
    puts "[5] To Continue"
    puts "---------Side Item---------".colorize(:blue)

    puts "What side would you like to add?"
    add_item = gets.strip.to_i

    case add_item
      when 1
        puts "You added #{@side_item[0][:item]} to the cart"
        @tray.add_to_cart(@side_item[0])
      when 2
        puts "You added #{@side_item[1][:item]} to the cart"
        @tray.add_to_cart(@side_item[1])
      when 3
        puts "You added #{@side_item[2][:item]} to the cart"
        @tray.add_to_cart(@side_item[2])
      when 4
        puts "You added #{@side_item[3][:item]} to the cart"
        @tray.add_to_cart(@side_item[3])
      when 5
        drink_menu
      else
        puts "please enter valid input"
    end
    puts "Add another item"
  end
end

def drink_menu
  while true
    @drink_item.each_with_index do |item, i|
      drink = MenuItems.new(item[:item], item[:price], item[:calories], i)
      drink.display_items
    end
    puts "[5] To Invoice"
    puts "--------- Drinks ---------".colorize(:blue)

    puts "What side would you like to add?"
    add_item = gets.strip.to_i

    case add_item
      when 1
        puts "You added #{@drink_item[0][:item]} to the cart"
        @tray.add_to_cart(@drink_item[0])
      when 2
        puts "You added #{@drink_item[1][:item]} to the cart"
        @tray.add_to_cart(@drink_item[1])
      when 3
        puts "You added #{@drink_item[2][:item]} to the cart"
        @tray.add_to_cart(@drink_item[2])
      when 4
        puts "You added #{@drink_item[3][:item]} to the cart"
        @tray.add_to_cart(@drink_item[3])
      when 5
        @tray.invoice
        closing_remarks
      else
        puts "please enter valid input"
    end
    puts "Add another item"
  end
end

def closing_remarks
  if @custy.instance_variable_get(:@money) < @tray.instance_variable_get(:@total)
    puts "What! You cant pay! Get out!"
    exit 2
  else
    @money -= @tray.instance_variable_get(:@total)
    puts "Money: #{@money}"
  end

  puts "Thank you, would you like to shop again?"
  puts "1) Yes"
  puts "2) No"
  input = gets.chomp

  while true
    case input
      when 1
        main_dish
      when 2
        puts "Goodbye, come again!"
        exit 1
      else
        puts "Your making no sense"
    end
  end
end






@entree_item = [{item: "Cheese Burger", price: 6.95, calories: 900},
  {item: "Spaghetti", price: 5.95, calories: 725},
  {item: "Hot-Doggie", price: 3.75, calories: 550},
  {item: "Noodles", price: 6.25, calories: 670}
]

@side_item = [{item: "Fries", price: 2.55, calories: 350},
  {item: "loaded Potato", price: 3.25, calories: 420},
  {item: "Fruit", price: 3.55,calories: 190},
  {item: "Salad", price: 3.55, calories: 210}
]

@drink_item = [{item: "Water", price: 0.00,   calories: 900},
  {item: "Soda", price: 1.75, calories: 725},
  {item: "Orange-Juice", price: 2.25, calories: 550},
  {item: "Chocolate-Milk", price: 2.15, calories: 670}
]

lunch_time
