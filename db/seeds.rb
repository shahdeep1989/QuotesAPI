# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Migrations
# rails g migration add_category_id_to_quotes category_id:integer
# rails g migration RemoveIndexValFromQuotes index_val:integer
# rails g migration AddAuthorToQuotes author:string


Category.create(:name => "Money")
Category.create(:name => "Design")
Category.create(:name => "Entrepreneurship/Business")
Category.create(:name => "Fitness")
Category.create(:name => "General Motivation")


# Category.create(:name => "Health")
# Category.create(:name => "Love")
# Category.create(:name => "General")


# Quote.create(:quote=>"Health is welth.", :author => "", :cnt => 0, :category_id => 1)
# Quote.create(:quote=>"Prevention is better than cure.", :author => "", :cnt => 0, :category_id => 1)


# Quote.create(:quote=>"Love is life.", :author => "", :cnt => 0, :category_id => 2)


# Quote.create(:quote=>"Simple living, High thinking.", :author => "", :cnt => 0, :category_id => 3)