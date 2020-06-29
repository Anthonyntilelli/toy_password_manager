#  Toy Password Manager

A simple password manager for Flatiron Rails project. Please do not use the password manager for any real usage.

## Installation

The package manager is [gems](https://rubygems.org/) managed by [bundler](https://bundler.io/).

1. Clone this project
2. Get [Github Oauth key](https://github.com/omniauth/omniauth-github)
3. Fill in `.env.example` and rename to `.env`
4. Run bash below
```bash
bundler install
bundler exec rails db:migrate
bundler exec rails db:seed # if you want test users
```

## Usage

```bash
bundler exec rails s
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
