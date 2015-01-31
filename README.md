# Florrick

This is a Rails library which integrates with Active Records and provides some
awesome user-initiated string interpolations for your web apps. For example, have
you ever needed to allow users to insert their own variables into e-mail templates
or messages?

```
Hello {{user.full_name}} - thanks for signing up. Your username is {{user.username}}
and you registered from {{user.country.name}}. Many thanks. {{sender.name}}.
```

## Installation

```ruby
gem 'florrick', '~> 1.1'
```

## Usage

In order to start using this, you need to specify which Active Record variables
you want to expose. As an example, the following shows how a basic User model may
be constructed to allow access to a few methods and a relationship.

```ruby
class User < ActiveRecord::Base

  belongs_to :country

  florrick do
    # Provide access to the following fields. All fields must return either a String,
    # Integer, Fixnum, Date or DateTime object.
    string :first_name, :last_name, :username, :full_name, :created_at

    # Provide access to the following belongs_to relationships. The models associated
    # with these relationships must also specify their own florrick definitions
    # as shown below.
    relationship :country

    # Provide access to a field with an alternative name (here we allow an underscore
    # to be provided for usernames).
    string(:user_name) { username }
  end

  # Return the user's full name. This method is included above and any instance methods
  # on the model can be included.
  def full_name
    "#{first_name} #{last_name}"
  end

end

class Country < ActiveRecord::Base
  florrick do
    string :name, :tld, :currency
  end
end
```

Once you have configured your models, you can convert a string:

```ruby
user    = User.first
string  = "Hello {{user.full_name}}. Welcome to {{user.country.name}}!"
Florrick.convert(string, :user => user) #=> "Hello Dave Smith. Welcome to Germany!"
```

## Fallback

If a string intepolation can't be completed, the default behaviour will just do
nothing and you'll just see your interpolation in the result.

However, you can add a fallback value to any object which will returned if the
variable requested doesn't exist or a formatter (see below) is not suitable. This
is achieved by simply adding your fallback string as shown below:

```ruby
You live in: {{user.country.name | unknown country}}
```

If at any point it cannot determine a value for a given interpolation, it will simply return do nothing.

## Formatters

This library also includes support for formatting of interpolated strings. For example:

```text
Hello {{user.full_name.upcase}}, double your age is {{user.age.double}}!
```

If any errors occurred while trying to format a value, it will return a '???' string.

### Built-in formatters

Strings

* `downcase` - converts all letters to lowercase
* `upcase` - converts all letters to uppercase
* `humanize` - capitalizes the first letters and downcases all others
* `sha1` - returns a SHA1 hash for the value
* `md5` - returns an MD5 hash for the value

Numerics

* `double` - doubles the value
* `triple` - triples the value

Date/timestamps

* `long_date` - Sunday 23rd October 1960
* `long_date_without_day_name`
* `short_date`
* `short_date_without_day_name`
* `ddmmyyyy` - 23/10/1960
* `hhmm` - 14:52
* `hhmmss` - 14:52:10
* `hhmm12` - 02:52pm
* `hhmmss12` - 02:52:10pm

### Registering your own formatters

As well as using the built-in formatters, you can register your own as shown below. You an also use
this to override any of the built-in formatters. The first argument is the name of the formatter, the
second is an array of "types" which the formatting can be applied to (String, Numeric, Date or Time).

```ruby
Florrick::Formatter.add 'add5', [Numeric] do |value|
  value +5
end
```


## Running Tests

If you want to run the test suite for the application, just run the following.

```
bundle install
bundle exec rake
```
