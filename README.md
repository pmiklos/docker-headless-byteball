# docker-headless-obyte
Docker image for headless-obyte

The main purpose of this docker image is to run a headless wallet in a docker container
exposing the wallet functionality via the RPC interface.

## Usage

The simplest way to create the docker image and run headless-obyte is using the provided
`headless-obyte.sh` script. For manual building and running, see instructions below.

```console
$ docker build -t headless-obyte .
$ docker run -it headless-obyte
```

although it is always a good idea to give a container a name you can remember:

```console
$ docker run -it --name my-headless-obyte headless-obyte
```

Running the container at the first time will set up some configuration items
such as the name of the device so it is important to run the container in an
interactive mode. When finished, release the container by pressing Ctrl-p Ctrl-q.
That will detach the console with leaving the container running.

To stop the container and then restart it again, use:

```console
$ docker stop my-headless-obyte
$ docker start -i my-headless-obyte
```

Again, the container has to be started in interactive mode because the app asks
for a passphrase.

### Using volumes

Although the headless-obyte docker image has been set up to create a volume
and store the obyte runtime files on the host filesystem, using a named volume
is recommended so containers can be dropped and recreated easily by referencing
the existing storage by a simple name:

```console
$ docker volume create --name obyte
$ docker run -it --name my-headless-obyte -v obyte:/obyte headless-obyte
```

NOTE: The configuration files are stored in the `/obyte` folder inside the container. 

### Changing the configuration

In order to change the configuration file, stop the headless-obyte container
start a new one like below:

```console
$ docker run -it --rm -v obyte:/obyte headless-obyte vi /obyte/conf.json
```

This will mount the named obyte volume and open the conf.json file in the
`vi` text editor. When you quite from `vi` the container will automatically
delete itself due to the `--rm` flag.

Now you can start the container again and the app will start up with the 
changed configuration.

See configuration options here:
* [byteball/ocore](https://github.com/byteball/ocore)
* [byteball/headless-obyte](https://github.com/byteball/headless-obyte)

### Checking the log file

In case you need to check the log files you can use the following command:

```console
$ docker logs headless-obyte
```

### Exposing port to the host system

If you enabled the default websocket port (6611) you may want to map it a port
on your host system. You have to create the container as below, but you may
first want to stop and remove the running container before creating a new one.

```console
$ docker stop my-headless-obyte
$ docker rm my-headless-obyte
$ docker run -it --name my-headless-obyte -v obyte:/obyte -p 6611:6611 headless-obyte
```

This will map the 6611 port of the host system to the 6611 port of the container.

