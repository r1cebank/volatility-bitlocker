FROM blacktop/yara:3.5

LABEL maintainer "https://github.com/r1cedbank"

ENV VOL_VERSION 2.5

# Install Volatility Dependancies
RUN apk add --no-cache ca-certificates zlib py-pillow py-crypto py-lxml py-setuptools
RUN apk add --no-cache -t .build-deps \
                           openssl-dev \
                           python-dev \
                           build-base \
                           zlib-dev \
                           libc-dev \
                           jpeg-dev \
                           automake \
                           autoconf \
                           py-pip \
                           git \
  && export PIP_NO_CACHE_DIR=off \
  && export PIP_DISABLE_PIP_VERSION_CHECK=on \
  && pip install --upgrade pip wheel \
  && pip install simplejson \
                 construct \
                 openpyxl \
                 haystack \
                 distorm3 \
                 colorama \
                 ipython \
                 pycoin \
                 pytz \
  && cd /tmp \
  && echo "===> Installing Volatility from source..." \
  && git clone --recursive --branch $VOL_VERSION https://github.com/volatilityfoundation/volatility.git \
  && cd volatility \
  && python setup.py build install \
  && rm -rf /tmp/*

# Install bitlocker plugin
RUN cd /tmp \
  && echo "===> cloning elceef/bitlocker..." \
  && git clone --recursive https://github.com/elceef/bitlocker.git \
  && cd bitlocker \
  && mkdir -p /plugins \
  && cp bitlocker.py /plugins \
  && rm -rf /tmp/*

# Remove build deps
RUN apk del --purge .build-deps

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["su-exec","nobody","/sbin/tini","--","vol.py"]
CMD ["-h"]