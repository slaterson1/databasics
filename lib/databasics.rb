require "active_record"
require "yaml"
require "pry"

require "databasics/version"
require "databasics/user"
require "databasics/address"
require "databasics/order"
require "databasics/item"

db_config = YAML.load(File.open("config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

module Databasics
  class App

  	
  	def create_user
  		puts "First name: "
  		first_name = gets.chomp

  		puts "Last name: "
  		last_name = gets.chomp

  		puts "Email: "
  		email = gets.chomp

  		Databasics::User.find_or_create_by(first_name: "#{first_name}", last_name: "#{last_name}", email: "#{email}")
  		user = Databasics::User.last
  		puts "User ID is: #{user.id}"
  	end
  	
  	def display_address
  		puts "Input user ID to display address: "
  		user_id = gets.chomp

  		Databasics::Address.find_by(user_id: "#{user_id}")
  		address = Databasics::Address.first
  		puts "Address is: #{address.street}, #{address.city}, #{address.state}, #{address.zip}"
  	end
  	
  	def past_orders
  		puts "Input user ID to display previous orders: "
  		user_id = gets.chomp

  		orders = Order.includes(:item).where(user_id: user_id)
      orders.each do |orders|
      puts "You ordered: #{orders.quantity} #{orders.item.title.pluralize}"
  		
  	end

  	def new_order
      puts "User ID: "
      user_id = gets.chomp

      puts "Item ID: "
      item_id = gets.chomp

      puts "Quantity: "
      quantity = gets.chomp

      Databasics::Order.find_or_create_by(user_id: "#{user_id}", item_id: "#{item_id}", quantity: "#{quantity}")
      user = Databasics::Order.last
      puts "Order is placed: #{user.id}, #{item_id}, #{quantity}"
  	end	
    end
  end
end

app = Databasics::App.new