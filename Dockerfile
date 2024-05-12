FROM node:8.7.0-slim
LABEL maintainer="AoEiuV020 <aoeiuv020@gmail.com>"
RUN echo 'deb [trusted=yes] http://archive.debian.org/debian/ jessie main' >/etc/apt/sources.list && apt-get update -y && apt-get install -y  --no-install-recommends git sudo tar libpcre3-dev openssl libssl-dev gcc g++ automake zlib1g-dev make psmisc && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /ps4broadcast
RUN wget http://nginx.org/download/nginx-1.18.0.tar.gz && tar -xvf nginx-1.18.0.tar.gz && cd nginx-1.18.0 && git clone https://github.com/Tilerphy/nginx-rtmp-module.git && ./configure --prefix=/usr/local/nginx/ --add-module=./nginx-rtmp-module && make CFLAGS='-Wno-implicit-fallthrough' && make install && rm -rf nginx*
RUN rm -rf /usr/local/nginx/conf/rtmp.conf.d && mkdir /usr/local/nginx/conf/rtmp.conf.d && chmod 777 /usr/local/nginx/conf/rtmp.conf.d && chmod 777 /usr/local/nginx/sbin/nginx && sed -i "s/rtmp { include \/usr\/local\/nginx\/conf\/rtmp.conf.d\/\*;}//g" /usr/local/nginx/conf/nginx.conf && sed -i "s/#user  nobody;/rtmp { include \/usr\/local\/nginx\/conf\/rtmp.conf.d\/*;}\n#user  nobody;/g"  /usr/local/nginx/conf/nginx.conf
RUN git clone --branch master --depth 1 https://github.com/Tilerphy/ps4broadcast.git 
WORKDIR /ps4broadcast/ps4broadcast
RUN npm install
RUN cp -R ./douyu/* node_modules
COPY append.js ./append.js
RUN cat append.js >> start.js
EXPOSE 26666 1935 6667
CMD /usr/local/bin/node start.js