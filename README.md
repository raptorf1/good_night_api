# [Tripla.io](https://en.tripla.io/) Hiring Assignment

- **Ruby version**

-- 2.7.6

- **Rails version**

-- 5.2.8

- **Configuration**

-- Clone the repository on your local machine.

-- Run `bundle` to install all project gems.

-- Run `rails db:setup` to create the databases and apply the migrations.

-- Fire up the server by running `rails s` on your local terminal.

-- Using `curl` or any other similar tool (i.e. Postman), you can hit the created endpoints.

- **Endpoints**

```
GET       /api/v0/users
get all users in the system

GET       /api/v0/users/:id
get specific user in the system along with their sleep records and those of their firends

POST      /api/v0/users
create a new user in the system

DELETE    /api/v0/users/:id
delete an existing user
```

```
GET       /api/v0/sleep_wake_times
get all sleep records in the system

POST      /api/v0/sleep_wake_times
create a sleep record in the system

PUT       /api/v0/sleep_wake_times/:id
update an existing sleep record in the system
```

```
POST      /api/v0/follows
follow another user

DELETE    /api/v0/follows/:id
unfollow a user
```

- **Tests**

-- The project is tested using `Rspec v.3.9.1`. To run all tests navigate from your terminal into the project folder and run `rspec`.

- **Code Prettify**

-- The code is prettified with the `Prettier` gem. You can try it by runing `bundle exec rbprettier --write '**/*'` in your terminal.
