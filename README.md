my first microservice written in R
====

R is fun:)

## Starting

`r --file=server.R` should automatically start up, install deps and run the app

## `127.0.0.1:9000/my-app/csv`

Returns the `mtcars` in csv format.

## `127.0.0.1:9000/my-app/csv?upload=true`

Uploads the csv to google drive

## `127.0.0.1:9000/my-app/csv?upload=true&notify=true`

Uploads the csv to google drive and notification to slack

## TODO

* it isn't a microservice since it does 3 things (uploading, notifying, returnin csv)
* logging
* better dependecy handling

## LICENSE

MIT
