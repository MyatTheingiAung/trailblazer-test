# Bulletin Board Trailblazer

## Requirements
- Ruby 2.6.9
- MySQL 5.7 or 8
- Node 16.17.1

## Installation

Clone the repo locally:
```
https://github.com/MyatTheingiAung/trailblazer-test.git
```

`cd` into cloned directory and install dependencies. run below command one by one.
```bash
npm install
bundle install
```

## Database Migration

Run database creations:
```
rails db:create
```

Run database migrations:
```
rails db:migrate
```

Run database seeder:
```
rails db:seed
```

## Server Run

Run the dev server:
```
rails serve
```

Visit below url:
```
http://127.0.0.1:3000/
```

## Rspec 

Run database seeder:
```
rails db:seed RAILS_ENV=test
```

Run rspec in console:
```
rspec
```

