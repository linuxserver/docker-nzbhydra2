[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/theotherp/nzbhydra2
[hub]: https://hub.docker.com/r/linuxserver/hydra2/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/hydra2
[![](https://images.microbadger.com/badges/version/linuxserver/hydra2.svg)](https://microbadger.com/images/linuxserver/hydra2 "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/hydra2.svg)](https://microbadger.com/images/linuxserver/hydra2 "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/hydra2.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/hydra2.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-hydra2)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-hydra2/)

NZBHydra is a meta search for NZB indexers and the "spiritual successor" to NZBmegasearcH. It provides easy access to a number of raw and newznab based indexers. [hydra](https://github.com/theotherp/nzbhydra)

[![hydra](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/hydra-icon.png)][appurl]

## Usage

```
docker create --name=hydra2 \
-v <path to data>:/config \
-v <nzb download>:/downloads \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 5075:5075 linuxserver/hydra2
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 5075` - the port(s)
* `-v /config` - Where hydra2 should store config files
* `-v /downloads` - NZB download folder
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone EG. Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it hydra2 /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

The web interface is at `<your ip>:5075` , to set up indexers and connections to your nzb download applications.


## Info

* To monitor the logs of the container in realtime `docker logs -f hydra2`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' hydra2`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/hydra2`

## Versions

+ **11.01.18:** Initial Release.
