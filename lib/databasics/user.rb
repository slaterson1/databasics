module Databasics
  class User < ActiveRecord::Base
  	has_many :orders
  	has_many :addresses
  end
end
