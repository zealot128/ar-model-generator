# Ar::Model::Generator

Fast generation of activerecord scaffold models to an existing (mysql?) database.
## Installation

Add this line to your application's Gemfile:

    gem 'ar-model-generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar-model-generator

## Usage

Run:
```bash
ar-model-generator
```

The programm will ask you about the connection details for the database as well as the namespace. Afterwards it will generate all model files under PWD/app/models/NAMESPACE.

Only tested with mysql2 so far.

There are some corrections:

* if there is no 'id' column, there will be a ``self.primary_key = 'key'`` line in the model, with the first column which has "id" inside it's name
* if there is a type column, there will be a ``self.inheritance_column = :sti_type``, otherwise there are conflicts
* All models inherit from YourNamespace::Base, which is a abstract class to hold the connection information. The benefit is, that you can connect to multple databases, e.g. all Models under YourNamespace will use that connection instead your global development/production etc.

Usage of classes:

in your initializers:

```ruby
MyNamespace::Base.establish_connection :some_database_yml_key

# Now you can use your models like:

MyNamespace::User.where(:all_the_awesomeness => true)
```

## warning:

* no generation of habtm hm belongs\_to
* no composited primary keys
