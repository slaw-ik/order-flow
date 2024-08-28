FROM ruby:3.3.2-alpine

RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

WORKDIR /app

COPY Gemfile* ./

RUN gem install bundler

RUN bundle lock --add-platform x86_64-linux

RUN bundle install

RUN bundle binstubs --all

COPY . .

EXPOSE 3000

RUN touch $HOME/.bashrc

RUN echo "alias ll='ls -alF'" >> $HOME/.bashrc
RUN echo "alias la='ls -A'" >> $HOME/.bashrc
RUN echo "alias l='ls -CF'" >> $HOME/.bashrc
RUN echo "alias q='exit'" >> $HOME/.bashrc
RUN echo "alias c='clear'" >> $HOME/.bashrc

