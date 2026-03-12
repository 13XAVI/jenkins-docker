

# Installation
## Build the Jenkins BlueOcean Docker Image (or pull and use the one I built)
```
docker build -t myjenkins-blueocean:2.414.2 .

#IF you are having problems building the image yourself, you can pull from my registry (It is version 2.332.3-1 though, the original from the video)

docker pull devopsjourney1/jenkins-blueocean:2.332.3-1 && docker tag devopsjourney1/jenkins-blueocean:2.332.3-1 myjenkins-blueocean:2.332.3-1
```

## Create the network 'jenkins'
```
docker network create jenkins
```

## Run the Container both MacOS / Linux

```
docker run -d --name jenkin \
>   --restart=on-failure \
>   -p 7070:8080 -p 50000:50000 \
>   -v jenkins_home:/var/jenkins_home \
>   -v /var/run/docker.sock:/var/run/docker.sock \
>   learning:dev
```


## Get the Password
```
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```

## Connect to the Jenkins
```
https://localhost:7070/
```

## alpine/socat container to forward traffic from Jenkins to Docker Desktop on Host Machine

https://stackoverflow.com/questions/47709208/how-to-find-docker-host-uri-to-be-used-in-jenkins-docker-plugin
```
docker run -d --restart=always -p 127.0.0.1:2376:2375 --network jenkin -v /var/run/docker.sock:/var/run/docker.sock alpine/socat tcp-listen:2375,fork,reuseaddr unix-connect:/var/run/docker.sock
docker inspect <container_id> | grep IPAddress
```

## Using my Jenkins Python Agent
```
docker pull 13xavi/myjenkinsagents:python
```
