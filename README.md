# Hachi

[![Gem Version](https://badge.fury.io/rb/hachi.svg)](https://badge.fury.io/rb/hachi)
[![Ruby CI](https://github.com/ninoseki/hachi/actions/workflows/test.yml/badge.svg)](https://github.com/ninoseki/hachi/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/hachi/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/hachi?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/ninoseki/hachi/badge)](https://www.codefactor.io/repository/github/ninoseki/hachi)

Hachi(`蜂`) is a dead simple [TheHive](https://github.com/TheHive-Project/TheHive) API wrapper for Ruby.

**Note**: This library supports TheHive v4 & v5.

## Installation

```bash
gem install hachi
```

## Usage

Hachi tries to load API settings from `ENV` by default. Or you can set them manually.

| Name         | Default                     | Desc.                                          |
|--------------|-----------------------------|------------------------------------------------|
| api_key      | ENV["THEHIVE_API_KEY"]      | TheHive API key                                |
| api_endpoint | ENV["THEHIVE_API_ENDPOINT"] | TheHive API endpoint                           |
| api_version  | ENV["THEHIVE_API_VERSION"]  | TheHive API version (`nil` for v4, `v1` for v5 |

```ruby
require "hachi"

# when given nothing, it tries to load your API key from ENV
api = Hachi::API.new
# or you can set them manually
api = Hachi::API.new(api_endpoint: "http://your_api_endpoint", api_key: "yoru_api_key")
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
