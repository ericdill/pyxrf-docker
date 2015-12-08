Run pyxrf from within docker on your mac
========================================


1. Install XQuartz on your mac ::

    brew install socat
    brew cask install xquartz
    open -a XQuartz

   Note:: You might need to press cmd+N to open up a new XQuartz terminal

1. From within the XQuartz terminal ::

    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"


1. figure out the IP address of the virtual machine that is running
   docker with the following command ::

    ifconfig vboxnet0

and look for the ``vboxnet0`` section that should look something like ::

    vboxnet0: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
    	ether 0a:00:27:00:00:00
    	inet 192.168.99.1 netmask 0xffffff00 broadcast 192.168.99.255

Remember the ip address that follows ``inet``, which is, in this case ``192.168.99.1``

1. Run your docker image ::

    $ docker run -e DISPLAY=192.168.99.1:0 -it ericdill/skxray

1. This should drop you into your running docker container ::

    root@76fe104d76e9:/#

1. Type pyxrf and you should expect to see a GUI! ::

    $ pyxrf
