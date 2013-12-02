#DOCKER-VERSION 0.7.0
FROM ubuntu:12.04

#Install Node js
RUN apt-get install -y g++ curl libssl-dev apache2-utils
RUN apt-get install -y git-core
RUN git clone http://github.com/ry/node.git
RUN cd node

RUN useradd -d /home/shippable -m -s /bin/bash -p shippablepwd shippable;\
          echo 'export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> /etc/environment;\
              echo 'export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> /home/shippable/.bashrc;\
                  mkdir /home/shippable/.ssh;\
                      echo 'shippable ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;\
                          chown -cR shippable:shippable /home/shippable/;

RUN apt-get -y install --force-yes build-essential libxslt-dev libxml2-dev libpq5 libpq-dev git git-core wget curl g++ texinfo make vim;

RUN wget http://nodejs.org/dist/v0.10.21/node-v0.10.21.tar.gz;\
          tar -xvf node-v0.10.21.tar.gz;\
              cd node-v0.10.21;\
                  ./configure && make && make install;\
                       npm install -g grunt-cli;\
#RUN ./configure
#RUN make
#RUN sudo make install

ADD . /src

RUN cd /src; npm install;

RUN  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 ;\
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list ;\
    apt-get update -y ;\
    apt-get -y install --force-yes mongodb-10gen ;\
    mkdir -p /data/db/ ;


EXPOSE 3000

CMD ["node","/src/index.js"]


