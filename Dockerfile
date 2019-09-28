FROM ruby:2.3.3-alpine

LABEL maintainer="Yuki Okamoto <okamoto.yuki.0130@gmail.com>"

# install curl
RUN apk add --no-cache curl

# install peco
WORKDIR /tmp
RUN apk add --no-cache openssl
RUN wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
RUN tar xvf peco_linux_amd64.tar.gz
RUN mv peco_linux_amd64/peco /usr/local/bin
RUN rm -rf peco_linux_amd64

# create working dir and move there
RUN mkdir -p /root/jirest
WORKDIR /root/jirest

# copy source
COPY . .

# install dependency
RUN apk add --no-cache build-base
RUN gem install bundler -v 1.16.3
RUN bundle install --path vendor/bundle

# command
ENTRYPOINT ["/root/jirest/docker-entrypoint.sh"]
CMD ["help"]