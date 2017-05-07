# README.md

## Setup

Get Docker https://store.docker.com/

* MacOSX https://store.docker.com/editions/community/docker-ce-desktop-mac?tab=description

Check installation; you may need to use `sudo` depending on what environment/version-of-docker-machine you're running

```
docker --version
```

Build container `Dockerfile`

```
docker build -t myjupyter .
```

Check image exists

```
docker images
```





## Run

Start container

```
docker run -p 8888:8888 -v "`pwd`/notebook":/notebook -i -t myjupyter
```

Check container is running

```
docker ps
```

Direct your browser to `http://localhost:8888/?token=49f039d31855ab1c6247201be0cb742499f34e8b14f01cc6





## Shutdown

Get the container ID

```
docker ps
```

Remove the container

```
docker kill 1fa4ab2cf395
```

Remove image

```
docker rmi 1fa4ab2cf395
```





## Debug

To explore container -- run interactive `/bin/bash` directly on the container

```
docker exec -i -t 516c87927968 /bin/bash
```

