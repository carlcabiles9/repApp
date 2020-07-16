# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.new
user.email = 'test1@test.com'
user.password = 'test1234'
user.name = 'test1'
user.save!
user.add_role :admin

project = Project.new
project.name = 'Others'
project.user_id = '1'
project.save!
