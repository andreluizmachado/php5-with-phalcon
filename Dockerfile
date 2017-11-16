FROM nyanpass/php5.5:5.5.38-cli

RUN apt-get update \                                                             
    && apt-get install librabbitmq-dev git libzip-dev -y

RUN curl -L https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz -o phalcon.tar.gz \
    && tar -xf phalcon.tar.gz \
    && cd cphalcon*/build && ./install \
    && docker-php-ext-enable phalcon

RUN curl -L https://github.com/alanxz/rabbitmq-c/releases/download/v0.7.1/rabbitmq-c-0.7.1.tar.gz -o rabbitmq-c-0.7.1.tar.gz \
    && tar -xzvf   rabbitmq-c-0.7.1.tar.gz \
    && cd rabbitmq-c-0.7.1 \
    && ./configure --prefix=/usr/local/rabbitmq-c-0.7 \
    && make \
    && make install \
    && echo '/usr/local/rabbitmq-c-0.7' | pecl install amqp \
    && docker-php-ext-enable amqp

RUN docker-php-ext-install mysql zip

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN rm -rf rabbitmq-c-0.7.1.tar.gz rabbitmq-c-0.7.1 phalcon.tar.gz cphalcon* \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && docker-php-source delete
