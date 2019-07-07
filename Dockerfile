FROM centos:7
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
    yum install -y wget \
    ; \
    pecl install http://pecl.php.net/get/redis-4.3.0.tgz \
    ; \
# tar -xzvf redis-4.3.0.tgz \
# WORKDIR /redis-4.3.0
# RUN phpize
# RUN ./configure
# RUN make
# RUN make install
    echo -e ";  Enable redis extension module\nextension=redis.so" > /etc/php.d/redis.ini
# WORKDIR /
# rm -rf redis-4.3.0 redis-4.3.0.tgz
# RUN echo -e ":set encoding=utf-8\n\
# :set fileencodings=ucs-bom,utf-8,cp936\n\
# :set fileencoding=gbk\n\
# :set termencoding=utf-8" > /root/.vimrc
# RUN echo "export.UTF-8" >> /etc/profilesource /etc/profile
# RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# RUN yum install kde-l10n-Chinese -y
# RUN yum install glibc-common -y
# RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
# ENV LC_ALL zh_CN.UTF-8
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
RUN systemctl enable httpd.service
CMD ["/usr/sbin/init"]
EXPOSE 80 443
# RUN  httpd -v
# CMD ["httpd", "-DFOREGROUND"]
