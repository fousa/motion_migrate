# Motion Migrate

Core Data migration from your models in RubyMotion. Never open XCode again with this gem.

## Why

I love the [Nitron](https://github.com/mattgreen/nitron) gem created by @mattgreen. But I missed some features, and I really hate to open Xcode to create the data model. So I created some rake tasks that helped me created the Core Data model generation. Thanks to @mattgreen for starting this in the 0.3 branch of the [Nitron](https://github.com/mattgreen/nitron) project.

## Installation

Add this line to your Gemfile:

    gem 'motion_migrate'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install motion_migrate

## Usage

With this gem you can set every option you can while using the Xcode modelling tool. I'm not going to describe every option because I assume RubyMotion developers know how Core Data works.

The 'spec_project' is an example project with two models containing some properties and relationships.

But the main question is how to generate the Core Data model. Well start by defining the properties.

    class Plane < MotionMigrate::Model
      property :name,         :string
      property :multi_engine, :boolean, :default => false
    end

This will generate two properties, a name and a multi property. To add some relationships to it you can add belongs to to the model.

    class Plane < MotionMigrate::Model
      property :name,         :string
      property :multi_engine, :boolean, :default => false

      belongs_to :pilot, :class_name => "Pilot", :inverse_of => :planes
    end

Don't forget to add a has many or belongs to as a reverse relationship

    class Pilot < MotionMigrate::Model
      has_many :planes, :class_name => "Plane", :inverse_of => :pilot
    end

The relationships as defined above contain the minimal parameters you'll have to pass to the has many or belongs to.

Now the most important part, migrating the model. Just run this command to generate the data model from the current models.

    $ rake db:migrate

You can also reverto to a previous version of the Core Data model by running: 

    $ rake db:rollback

You can check out the other rake tasks by running:

    $ rake -T

## Example

But for me, the most obvious part is an small example application that shows you how this gem is used. Check out the spec_project en run it so you can see it in action.

## Todo

This is certainly not the end, still got a lot to do.

- [ ] Better version generation.
- [ ] Clean up the utility methods.
- [ ] Implement [mogenerator](https://github.com/rentzsch/mogenerator) functionality.
- [ ] Add << functionatlity to the relationships in orde to add objects.
- [ ] Try to handle relationships in a more Ruby on Railzy way.

## Tests

When contributing to this project make sure you run the tests to make sure everything keeps working like it should.

Run the migration tests by executing this command from the project root:

    $ rspec

When you want to test the functional integration with [Magical Record](https://github.com/magicalpanda/MagicalRecord) by moving to the spec_project folder and running the specs.

    $ rake spec

## Contributing

It would be awesome if you contribute!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Jelle Vandebeeck

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.