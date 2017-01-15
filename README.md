# docker-headless-byteball
Docker image for headless-byteball

## Usage

The simplest way to create the docker image and run headless-byteball is below.

```console
$ docker build -t headless-byteball .
$ docker run -it --name my-headless-byteball headless-byteball
```

Running the container at the first time will set set up some configuration items
such as the name of the device so it is important to run the container in an
interactive mode. When finished, release the container by pressing Ctrl-P Ctrl-Q.
That will detach the console with leaving the container running.

To stop the container and then restart it again, use:

```console
$ docker stop my-headless-byteball
$ docker start -i my-headless-byteball
```

Again, the container has to be started in interactive mode because the app asks
for a passphrase.

### Using volumes

Although the headless-byteball docker image has been set up to create a volume
and store the byteball runtime files on the host filesystem, using a named volume
is recommended so containers can be dropped and recreated easily by referencing
the existing storage by a simple name:

```console
$ docker volume create --name byteball
$ docker run -it --name my-headless-byteball -v byteball:/byteball headless-byteball
```

NOTE: The configuration files are stored in the `/byteball` folder inside the container. 

### Changing the configuration

In order to change the configuration file, stop the headless-byteball container
start a new one like below:

```console
$ docker run -it --rm -v byteball:/byteball headless-byteball vi /byteball/conf.json
```

This will mount the named byteball volume and open the conf.json file in the
`vi` text editor. When you quite from `vi` the container will automatically
delete itself due to the `--rm` flag.

Now you can start the container again and the app will start up with the 
changed configuration.

See configuration options here:
* [byteball/byteballcore](https://github.com/byteball/byteballcore)
* [byteball/headless-byteball](https://github.com/byteball/headless-byteball)

### Checking the log file

In case you need to check the log files you can use the following command:

```console
$ docker run -it --rm -v byteball:/byteball headless-byteball less /byteball/log.txt
```

### Exposing port to the host system

If you enabled the default websocket port (6611) you may want to map it a port
on your host system. You have to create the container as below, but you may
first want to stop and remove the running container before creating a new one.

```console
$ docker stop my-headless-byteball
$ docker rm my-headless-byteball
$ docker run -it --name my-headless-byteball -v byteball:/byteball -p 6611:6611 headless-byteball
```

This will map the 6611 port of the host system to the 6611 port of the container.

