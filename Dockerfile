# docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/your-app jadametz/serverspec
FROM ruby:2.4.1-alpine
LABEL maintainer="jesseadametz@gmail.com"

RUN apk add --update --no-cache build-base

COPY Gemfile Gemfile.lock ./
RUN bundle install

ENTRYPOINT ["rspec"]
CMD ["-h"]
