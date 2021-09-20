# ip-camera
Stream Raspberry Pi Cameras to a NGINX Server.


## Set up NGINX Server ##

1. Install Nginx and nginx rtmp module.

```
$ sudo apt install nginx

$ sudo apt install build-essential dpkg-dev libpcre3 libpcre3-dev libssl-dev zlib1g zlib1g-dev

$ git clone https://github.com/arut/nginx-rtmp-module.git

$ apt-get source nginx

$ cd nginx-1.18.0/

$ ./configure --with-compat --add-dynamic-module=../nginx-rtmp-module

$ make modules

$ sudo cp objs/ngx_rtmp_module.so /etc/nginx/modules/
```
[Source](https://hlsbook.net/hls-nginx-rtmp-module/])

2. Set up the Nginx config whit [nginx.conf]( ) and conifgure the needed items.

3. Modify the index.html and/or player pages as needed. The player page should match [this]( ) with the needed links.

4. Start the Nginx server: `sudo nginx` and `-s reload` if its already running. 

5. Install ffmpeg on the Raspberry Pi

```
$ sudo add-apt-repository ppa:mc3man/trusty-media

$ sudo apt-get update

$ sudo apt-get install ffmpeg
```

6. Run the stream with the desired configureation changes. 
```
raspivid -t 0 -w 1280 -h 720 -fps 20 -g 75 -fl -o - | ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -i pipe:0 -c:v copy -c:a aac -strict experimental -fflags +genpts -f flv -f flv rtmp://[SERVER]:1935/live/pi0
```


