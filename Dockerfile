FROM centos:7
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN curl -o /etc/yum.repos.d/CentOS7-Base-163.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo 
RUN yum install -y wget
RUN yum clean all
RUN yum makecache
RUN yum install -y php php-gd php-pdo php-xml php-devel php-xmlrpc php-process php-mysql php-mbstring php-bcmath php-odbc php-cli php-ldap php-common php-pear
RUN yum install -y gcc gcc-c++
RUN yum install -y httpd mod_ssl
RUN wget http://pecl.php.net/get/redis-4.3.0.tgz
RUN tar -xzvf redis-4.3.0.tgz
WORKDIR /redis-4.3.0
RUN phpize
RUN ./configure
RUN make
RUN make install
RUN echo -e ";  Enable redis extension module\nextension=redis.so" > /etc/php.d/redis.ini
WORKDIR /
RUN rm -rf redis-4.3.0 redis-4.3.0.tgz
RUN echo -e ":set encoding=utf-8\n\
:set fileencodings=ucs-bom,utf-8,cp936\n\
:set fileencoding=gbk\n\
:set termencoding=utf-8" > /root/.vimrc
#RUN echo "export.UTF-8" >> /etc/profilesource /etc/profile
RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum install kde-l10n-Chinese -y
RUN yum install glibc-common -y
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL zh_CN.UTF-8
RUN systemctl enable httpd.service
ENTRYPOINT ["/usr/sbin/init"]
