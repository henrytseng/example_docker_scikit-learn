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

Create the data set of 200k examples

    cd notebook/data/; ./create_example.rb --limit 200000 --do_write
Direct your browser to http://localhost:8888/?token=49f039d31855ab1c6247201be0cb742499f34e8b14f01cc6 



Check your environment with `notebook/check_env.ipynb`



Open up the notebook `notebook/01 - Example.ipynb` to take a look at the example.  





## Shutdown

Get the container ID

```
docker ps
```

Remove the container (e.g. - if the container ID is `1fa4ab2cf395`)

```
docker kill 1fa4ab2cf395
```

Get a list of images

```
docker images
```

Remove image (e.g. - if the image ID is `1fa4ab2cf395`)

```
docker rmi 1fa4ab2cf395
```





## Debug

To explore container -- run interactive `/bin/bash` directly on the image

```
docker exec -i -t 516c87927968 /bin/bash
```

