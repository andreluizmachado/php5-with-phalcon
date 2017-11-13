FROM nyanpass/php5.5:5.5.38-cli

RUN curl -L https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz -o phalcon.tar.gz \
    && tar -xf phalcon.tar.gz \
    && cd cphalcon*/build && ./install \
    && echo 'extension=phalcon.so' > /usr/local/etc/php/conf.d/phalcon.ini

RUN apt-get update \
    && apt-get install libzip-dev -y \
    && pecl install zlib zip \
    && echo 'extension=zip.so' > /usr/local/etc/php/conf.d/zip.ini

RUN apt-get install git -y

RUN rm -rf phalcon.tar.gz cphalcon* \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y

