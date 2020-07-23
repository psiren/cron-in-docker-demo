# Running crons inside docker

This project showcases how to run crons inside an alpine docker container

## Details

We utilise the `/etc/periodic/` directory inside the container that crond has set up by default

The `startup.sh` script adds another entry in the crontab for running every minute copying in the cron tasks from the relevant directory

The project makes use of GitOps for the project name in the `Makefile`

## Building (with default values)

```
make build
```

## Building (overriding default settings)

Build an image with the version tag of **`1.0`**

```
make build VERSION=1.0
```

## Running (in foreground)

Runs the app in the command line maintaining focus and `stdout`

```
make up
```

Wait for the clock to tick and you should see output printed to the commandline

> Use CTRL+C to stop the container

## Running (in background)

```
make service
```

## Attaching

```
make attach
```
