# portfolio

This is a Ruby on Rails (6) application for managing a developer portfolio,
you are the owner, you manage your contact information and your projects. You
must login to change things, and when you are done you just logout, everything
is just joy and hapinness.

Actually, I just wanted to practice with Ruby on Rails.

![portfolio demo gif](./doc/demo.gif)

## Setup

### Requirements

- rails 6.0.2.2
- ruby 2.6.5
- bundler 1.17.2
- postgresql 12.2
- yarn 1.22.4

### Setup

First, you need to have postgresql installed in your system, and you should
also have a postgresql role with the same name as you login user, this role
should also have permission to create databases. An explanation on how to
do this for Ubuntu 18.04 is in
[this link](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04).

1. Clone this repository

```zsh
git clone https://github.com/santiago-rodrig/portfolio.git
```

2. Change your current directory to that of the repository

```zsh
cd portfolio
```

3. Install the required dependencies

```zsh
bundle install && yarn install --check-files
```

4. Set-up the databases

```zsh
rails db:create && rails db:migrate
```

5. Fire-up the local server to see the results

```zsh
rails server
```

#### Optional

You can also run the test suite for the application, to make sure that everything
is working well.

```zsh
rails test
```

## License

This project is licensed under the [MIT](./LICENSE) license, which
basically means that you can do whatever you want with the code under the
condition of giving credit to its author and noticing the license.

## Credits

This application was developed by
[santiago-rodrig](https://github.com/santiago-rodrig).
