# Pherialize filter plugin for Embulk

deserialize PHP serialized strings to extract values as new column.

see. [keichan34/php-serialize](https://github.com/keichan34/php-serialize)

## Overview

* **Plugin type**: filter

## Configuration

- **serialized_column**: target serialized column (string, required)
- **extract_fields**: out key name (array, default: [])
- **drop_serialized_column**: drop serialized column from out schema (boolean, default: false)

## Example

```yaml
filters:
  - type: pherialize
    serialized_column: serialized_data
    drop_serialized_column: true
    extract_fields:
      - {name: id, type: long}
      - {name: name, type: string}
out:
  type: stdout
```

## Build

```
$ rake
```
