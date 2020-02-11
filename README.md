# ruboty-redash

A ruboty plugin that fetches data from Redash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-redash', github: 'mallowlabs/ruboty-redash'
```

And then execute:

    $ bundle

## Usage

```
@ruboty redash show <query_id> <format>
```

You can get `query_id` from the URL in query page.

Example:

```
@ruboty redash show 9 Today's KPI is <%= data['rows'][-1]['kpi'] =>
```

`format` is specified with ERB.

In ERB, `data` format is below:

```json
{
    "rows": [
        {
            "kpi": 123,
            ...
        },
        ...
    ],
    "columns": [
        {
            "friendly_name": "kpi",
            "type": "integer",
            "name": "kpi"
        },
        ...
    ]
}
```

columns names ​​vary by environments.

## Development

How to run specs:
```
$ bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mallowlabs/ruboty-redash.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
