FROM centos:7
# RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
#     ; \
#     curl -o /etc/yum.repos.d/CentOS7-Base-163.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo \
#     ; \
RUN yum install -y epel-release \
    ; \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    ; \
    yum clean all \
    ; \
    yum makecache \
    ; \    
    yum install -y mod_php56w \
    php56w-gd \
    php56w-pdo \
    php56w-xml \
    php56w-devel \
    php56w-common \
    php56w-xmlrpc \
    php56w-process \
    php56w-mysqlnd \
    php56w-mbstring \
    php56w-bcmath \
    php56w-odbc \
    php56w-ldap \
    php56w-pear \
    ; \
    yum install -y gcc gcc-c++ autoconf pcre-devel \
    ; \  
    yum install -y httpd mod_ssl \
    ; \    
    pecl install http://pecl.php.net/get/redis-4.3.0.tgz \
    ; \
    echo -e ";  Enable redis extension module\nextension=redis.so" > /etc/php.d/redis.ini
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
# RUN systemctl enable httpd.service
EXPOSE 80
RUN  httpd -v
ENTRYPOINT ["httpd -DFOREGROUND"]
