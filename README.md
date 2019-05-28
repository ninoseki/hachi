# Hachi

[![Gem Version](https://badge.fury.io/rb/hachi.svg)](https://badge.fury.io/rb/hachi)
[![Build Status](https://travis-ci.org/ninoseki/hachi.svg?branch=master)](https://travis-ci.org/ninoseki/hachi)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/hachi/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/hachi?branch=master)

Hachi(`蜂`) is a dead simple [TheHive](https://github.com/TheHive-Project/TheHive) API wrapper for Ruby.

## Installation

```bash
gem install hachi
```

## Usage

```ruby
require "hachi"

# when given nothing, it tries to load your API key from ENV["THEHIVE_API_KEY"] & API endpoint from ENV["THEHIVE_API_ENDPOINT"]
api = Hachi::API.new
# or you can set them manually
api = Hachi::API.new(api_endpoint: "http://your_api_endpoint", api_key: "yoru_api_key")

# list alerts
api.alert.list

# search atrifacts
api.artifact.search(data: "1.1.1.1", data_type: "ip")
```

See `samples` for more.

## Implemented methods

### Alert

| HTTP Method | URI                               | Action                      | API method                                                                                                                                                          |
|-------------|-----------------------------------|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| GET         | /api/alert                        | List alerts                 | `#api.alert.list`                                                                                                                                                   |
| POST        | /api/alert/_search                | Find alerts                 | `#api.alert.search(attributes:, range: "all")`                                                                                                                      |
| PATCH       | /api/alert/_bulk                  | Update alerts in bulk       | N/A                                                                                                                                                                 |
| POST        | /api/alert/_stats                 | Compute stats on alerts     | N/A                                                                                                                                                                 |
| POST        | /api/alert                        | Create an alert             | `#api.alert.create(title:, description:, severity: nil, date: nil, tags: nil, tlp: nil, status: nil, type:, source:, source_ref: nil, artifacts: nil, follow: nil)` |
| GET         | /api/alert/:alertId               | Get an alert                | `#api.alert.get_by_id(id)`                                                                                                                                          |
| PATCH       | /api/alert/:alertId               | Update an alert             | N/A                                                                                                                                                                 |
| DELETE      | /api/alert/:alertId               | Delete an alert             | `#api.alert.delete_by_id(id)`                                                                                                                                       |
| POST        | /api/alert/:alertId/markAsRead    | Mark an alert as read       | N/A                                                                                                                                                                 |
| POST        | /api/alert/:alertId/markAsUnread  | Mark an alert as unread     | N/A                                                                                                                                                                 |
| POST        | /api/alert/:alertId/createCase    | Create a case from an alert | N/A                                                                                                                                                                 |
| POST        | /api/alert/:alertId/follow        | Follow an alert             | N/A                                                                                                                                                                 |
| POST        | /api/alert/:alertId/unfollow      | Unfollow an alert           | N/A                                                                                                                                                                 |
| POST        | /api/alert/:alertId/merge/:caseId | Merge an alert in a case    | N/A                                                                                                                                                                 |

### Artifact(Observable)

| HTTP Method | URI                                    | Action                          | API method                                                                            |
|-------------|----------------------------------------|---------------------------------|---------------------------------------------------------------------------------------|
| POST        | /api/case/artifact/_search             | Find observables                | `#api.artifact.search(attributes, range: "all")`                                      |
| POST        | /api/case/artifact/_stats              | Compute stats on observables    | N/A                                                                                   |
| POST        | /api/case/:caseId/artifact             | Create an observable            | `#api.artifact.create(case_id, data:, data_type:, message: nil, tlp: nil, tags: nil)` |
| GET         | /api/case/artifact/:artifactId         | Get an observable               | `#api.artifact.get_by_id(id)`                                                         |
| DELETE      | /api/case/artifact/:artifactId         | Remove an observable            | `#api.artifact.delete_by_id(id)`                                                      |
| PATCH       | /api/case/artifact/:artifactId         | Update an observable            | N/A                                                                                   |
| GET         | /api/case/artifact/:artifactId/similar | Get list of similar observables | `#api.artifact.similar(id)`                                                           |
| PATCH       | /api/case/artifact/_bulk               | Update observables in bulk      | N/A                                                                                   |

### Case

| HTTP Method | URI                                | Action                                | API method                                                                                                           |
|-------------|------------------------------------|---------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| GET         | /api/case                          | List cases                            | `#api.case.list`                                                                                                     |
| POST        | /api/case/_search                  | Find cases                            | `#api.case.search(attributes, range: "all")`                                                                         |
| PATCH       | /api/case/_bulk                    | Update cases in bulk                  | N/A                                                                                                                  |
| POST        | /api/case/_stats                   | Compute stats on cases                | N/A                                                                                                                  |
| POST        | /api/case                          | Create a case                         | `#api.case.create(title:, description:, severity: nil, start_date: nil, owner: nil, flag: nil, tlp: nil, tags: nil)` |
| GET         | /api/case/:caseId                  | Get a case                            | `#api.case.get_by_id(id)`                                                                                            |
| PATCH       | /api/case/:caseId                  | Update a case                         | N/A                                                                                                                  |
| DELETE      | /api/case/:caseId                  | Remove a case                         | `#api.case.delete_by_id(id)`                                                                                         |
| GET         | /api/case/:caseId/links            | Get list of cases linked to this case | `#api.case.links(id)`                                                                                                |
| POST        | /api/case/:caseId1/_merge/:caseId2 | Merge two cases                       | N/A                                                                                                                  |

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
