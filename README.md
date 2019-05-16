# docker-shinymap
[![](https://img.shields.io/docker/cloud/automated/hnskde/shinymap.svg)](https://hub.docker.com/r/hnskde/shinymap/builds/)
[![](https://img.shields.io/docker/cloud/build/hnskde/shinymap.svg)](https://hub.docker.com/r/hnskde/shinymap/builds/)
[![](https://img.shields.io/docker/pulls/hnskde/shinymap.svg)](https://hub.docker.com/r/hnskde/shinymap)

## Run

### Very short docs
Assuming docker is installed and to start the container at its initial (pristine) state, run the following command:
```
docker run -v ~/.ssh:/home/rstudio/.ssh -e PASSWORD=password --rm -p 8787:8787 hnskde/shinymap:latest
```
The ```-v``` option mounts the directory holding your ssh-files (keys
and config, found in ```~/.ssh``` in the example above) so they
become available within the container (in the```/home/rstudio/.ssh```
directory). Please adjust according to where your .ssh directory
resides on your host.

The ```-e``` option sets the password to be used logging into RStudio
in the container. Otherwise, you just have to type it...

To stop a running container press ```ctr + c``` (or similar) on the same command line as the ```run``` command was issued.

To start an exiting container (with your previous work preserved), run the following command:
```
docker start [container_name]
```

To stop a container started with the above command, run:
```
docker stop [container_name]
```

To list available container names, run the following command:
```
docker ps -a
```
From the listing provided use either _CONTAINER ID_ or _NAMES_ field for [container_name]


After starting the container your dockerized RStudio should be
available at [localhost:8787](http://localhost:8787)

### More docs
Probably not spot on, but
[rap-dev-data](https://github.com/Rapporteket/docker/tree/master/rap-dev-data)
and
[rap-dev](https://github.com/Rapporteket/docker/tree/master/rap-dev)
might be of further help.

## Use
Once the container is started use git or RStudio git to checkout
[shinymap](https://github.com/Helseatlas/shinymap). The R package
_shinymap_ is already installed from the _master_ branch.
