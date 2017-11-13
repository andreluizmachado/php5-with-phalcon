FROM nyanpass/php5.5:5.5.38-cli

RUN curl -L https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz -o phalcon.tar.gz \
    && tar -xf phalcon.tar.gz \
    && cd cphalcon*/build && ./install \
    && echo 'extension=phalcon.so' > /usr/local/etc/php/conf.d/phalcon.ini

RUN apt-get update \
    && apt-get install libzip-dev -y \
    && pecl install zlib zip \
    && echo 'extension=zip.so' > /usr/local/etc/php/conf.d/zip.ini

RUN apt-get install librabbitmq-dev -y \
    && curl -L https://github.com/alanxz/rabbitmq-c/releases/download/v0.7.1/rabbitmq-c-0.7.1.tar.gz -o rabbitmq-c-0.7.1.tar.gz \
    && tar -xzvf   rabbitmq-c-0.7.1.tar.gz \
    && cd rabbitmq-c-0.7.1 \
    && ./configure --prefix=/usr/local/rabbitmq-c-0.7 \
    && make \
    && make install \
    && echo '/usr/local/rabbitmq-c-0.7' | pecl install amqp \
    && echo 'extension=amqp.so' > /usr/local/etc/php/conf.d/amqp.ini
 
RUN rm -rf rabbitmq-c-0.7.1.tar.gz rabbitmq-c-0.7.1 phalcon.tar.gz cphalcon* \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y

