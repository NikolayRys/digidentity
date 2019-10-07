# README
*Test task for Digidentity, done by N. Rys*

## The task
The Ruby Bank
1. Build a simple rails banking app.
2. Via the console you can create users with password.
3. User can log in.
4. Via the console you can give the user credit.
5. User has a bank account with balance.
6. Users can transfer money to each other.
7. Users may not have a negative balance on their account.
8. We need to figure out how a user obtained a certain balance.
9. It is important that money cannot just disappear or appear into account.

## My comment
Since the task is open-ended, I needed to make a call when to stop. Here are some things that I've left out:
* Tests for controllers
* Proper stylesheets
* Authentication that is not based on a session and can be hijacked
* Password salt
* Make the pages look prettier

## Usage
* To add a user: `User.create!(email: 'name@example.com', password: 'secret'`
* To give user an initial credit: `User.find_by(email: 'name@example.com').console_add_money(500)`
* Balance is stored in cents, both in transactions and user accounts.
* In preloaded data the passwords for all users match the part before @ sign, for example: `username@example.com` has password `username`
* Then please visit http://digidentity.rys.me/ and try it out

## The most important files
* [user.rb](app/models/user.rb)
* [user_test.rb](test/models/user_test.rb)
* [transfer.rb](app/models/transfer.rb)
* [transfer_test.rb](test/models/transfer_test.rb)
* [transactions_controller.rb](app/controllers/transactions_controller.rb)
* [sessions_controller.rb](app/controllers/sessions_controller.rb)
* [transactions index templatee](app/views/transactions/index.html.erb)
* [sessions new template](app/views/sessions/new.html.erb)

The other edits are relatively minor.
