# README

* Ruby version 
2.4+

* Rails version 
5.2+

* Database initialization
rails db:migrate
rake db:seed

* How to run the test suite
rails db:migrate RAILS_ENV=test
rake db:fixtures:load
rake

* Deployment instructions
rails server


* DATABASE Schemas

Based on .csv file data and requirements the following Database tables and schema are available:

Review:
    rating: int
    text: string
    end_date: date
    start_date: date
    sitter: belongs_to Sitter (association)

Owner:
    name: string
    image: string
    phone_number: string
    email: string
    dogs: has_many Dog (association)

Sitter:
    name: string
    image: string
    phone_number: string
    email: string
    stays: int
    sitter_score: int
    ratings_score: int
    overall_score: int
    reviews: has_many Review (association)

Dog:
    name: string
    owner: belongs_to Owner (association)
