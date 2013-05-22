# JqueryDatepick

Form helper for Rails that gives you a jQuery datepicker field.

The current version of the jQuery plugin is 4.1

## Installation

Add this line to your application's Gemfile:

    gem 'jquery_datepick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jquery_datepick

## Usage

Add this to your view.

    <%= datepicker_input "user","birthday" %>
	

Where "user" is your model name and "birthday" the name of the datefield.

You can also use it with the form helper like:

    <% form_for(@user) do |f| %>
      <%= f.datepicker 'birthday' %>
      <%= f.submit 'Create' %>
    <% end %>

Nested attributes are permitted as well:

    <% form_for(@user) do |f| %>
      <% f.fields_for(@nested) do |f2| %>
        <%= f2.datepicker 'birthday' %>
      <% end %>
      <%= f.submit 'Create' %>
    <% end %>

You can pass options as it would be a normal text_field, plus all the datepicker options available (http://jqueryui.com/demos/datepicker/#options)

    <%= datepicker_input(:foo, :att1, :minDate => -20, :maxDate => "+1M +10D", :tabindex => 70) %>

If you need a datetime picker, checkout https://github.com/Hermanverschooten/jquery_datetimepick.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
