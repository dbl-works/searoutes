# Original Repo

https://github.com/eurostat/searoute


To simplify deploy, we pulled in the [SeaRoute-war](https://jarcasting.de/artifacts/eu.europa.ec.eurostat/searoute-war/)
and removed all other files from the original repository.

> Eurostat is the statistical office of the European Union. This repository provides with open resources (prototypes, proofs of concept,...) developed in-house.


# Searoutes
## API

```
GET   http://localhost:5017/seaws?opos=174.8,-36.8&dpos=121.8,31.2&res=5
```

Returns

```json
{
  "status": "ok",
  "dist": 9815.2,
  "dFrom": 5.5,
  "dTo": 30.45,
  "geom": {
    "type": "MultiLineString",
    "coordinates": [
      [
        [
          121.8,
          31.2
        ],
        [
          121.4838,
          31.2398
        ],
        (...)
        [
          174.7678,
          -36.8422
        ],
        [
          174.8,
          -36.8
        ]
      ]
    ]
  }
}
```


## Local Testing

Build a docker image
```shell
docker build -t localhost/searoutes:3.6 .
```

Run it and expose e.g. port 5017:

```shell
docker run -it --rm -p 5017:5017 localhost/searoutes:3.6
```

(NOTE: on ECS, we default to exposing ports in the 5xxx range for internal side-car containers)


## Building & Publishing

https://hub.docker.com/repository/docker/dblworks/searoutes

```shell
docker pull dblworks/searoutes:3.6
```

```shell
export TAGNAME=3.6
```

Build:

On a x86 chip
```shell
docker build -t dblworks/searoutes:$TAGNAME .
```

On a ARM chip (for a x86 target):

```shell
docker build -t dblworks/searoutes:$TAGNAME . --platform amd64
```


Publish:

```shell
docker push dblworks/searoutes:$TAGNAME
```
