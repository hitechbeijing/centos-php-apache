FROM registry.cn-hangzhou.aliyuncs.com/hitechbeijing/c7-systemd
# RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# RUN curl -o /etc/yum.repos.d/CentOS7-Base-163.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
# RUN yum clean all
# RUN yum makecache
  RUN yum install -y php \
                     php-gd \
                     php-pdo \
                     php-pdo_mysql \
                     php-xml \
                     php-devel \
                     php-xmlrpc \
                     php-process \
                     php-mysqli \
                     php-mbstring \
                     php-bcmath \
                     php-odbc \
                     php-ldap \
                     php-common \
                     php-pear \
    ; \
    yum install -y gcc gcc-c++ \
    ; \
    yum install -y httpd mod_ssl \
    ; \
    yum install -y wget cmake openssl_devel \
    ; \
    pecl install http://pecl.php.net/get/redis-4.3.0.tgz \
    ; \
RUN  echo -e ";  Enable redis extension module\nextension=redis.so" > /etc/php.d/redis.ini
RUN wget https://codeload.github.com/alanxz/rabbitmq-c/tar.gz/v0.9.0 -O /tmp/rabbitmq-c-0.9.0.tar.gz
WORKDIR /tmp
RUN tar -xzvf rabbitmq-c-0.9.0.tar.gz
WORKDIR /tmp/rabbitmq-c-0.9.0
RUN mkdir build && cd build
RUN cmake ..
RUN cmake --build .
RUN make install
RUN curl http://pecl.php.net/get/amqp-1.9.3.tgz -o /tmp/amqp-1.9.3.tgz
WORKDIR /tmp
RUN tar -xzvf amqp-1.9.3.tgz
WORKDIR /tmp/amqp-1.9.3
RUN phpize
RUN ./configure --with-amqp --with-librabbitmq-dir=/usr/local
RUN make && make install
RUN ln -s /usr/local/lib64/librabbitmq.so.4 /usr/local/lib/librabbitmq.so.4
RUN echo -e ";  Enable amqp extension module\nextension=amqp.so" > /etc/php.d/amqp.ini
WORKDIR /tmp
RUN echo -e "<?php\ndate_default_timezone_set("GMT");\necho phpinfo();\n?>" > phpinfo.php
RUN php phpinfo.php | grep amqp | awk '/^amqp/{print $1 $2 $3}'
RUN php phpinfo.php | grep redis | awk '/^redis/{print $1 $2 $3}'
RUN systemctl enable httpd.service
WORKDIR /
# RUN rm -rf /tmp/*
CMD ["/usr/sbin/init"]
EXPOSE 80 443
# RUN  httpd -v
# CMD ["httpd", "-DFOREGROUND"]
