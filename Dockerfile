# Versions
#
# Erlang: 1:22.0.1-1
# Elixir: 1.8.1
# Phoenix: 1.4.6

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Elixir requires UTF-8
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y sudo wget curl inotify-tools git build-essential zip unzip bcrypt

# Download and install nodejs
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - && apt-get install -y nodejs
RUN npm i npm@latest -g

# Download and install Erlang package
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update

ENV ERLANG_VERSION 1:22.0.1-1

# Install Erlang
RUN apt-get install -y esl-erlang=$ERLANG_VERSION && rm erlang-solutions_1.0_all.deb

ENV ELIXIR_VERSION 1.8.1

# Install Elixir
RUN mkdir /opt/elixir \
  && cd /opt/elixir \
  && curl -O -L https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip \
  && unzip Precompiled.zip \
  && cd /usr/local/bin \
  && ln -s /opt/elixir/bin/elixir \
  && ln -s /opt/elixir/bin/elixirc \
  && ln -s /opt/elixir/bin/iex \
  && ln -s /opt/elixir/bin/mix

# Install hex & rebar
RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info

ENV PHOENIX_VERSION 1.4.6

# Install the Phoenix Mix archive
RUN yes | mix archive.install hex phx_new $PHOENIX_VERSION

WORKDIR /phoenix-website

EXPOSE 4000

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]