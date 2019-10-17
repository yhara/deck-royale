# orig: https://qiita.com/baban/items/99877f9b3065c4cf3d50

#
# --- stage 1 ---
#
FROM ruby:2.6-alpine as builder
RUN apk --update --no-cache add shadow sudo busybox-suid tzdata alpine-sdk sqlite-dev
WORKDIR /app
COPY Gemfile Gemfile.lock ./

# Install gems and run `make clean` for C extentions
RUN gem install bundler && \
    bundle install --without development test --path vendor/bundle && \
    find vendor/bundle/ruby -path '*/gems/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean

#
# --- stage 2 ---
#

FROM ruby:2.6-alpine
RUN apk --update --no-cache add shadow sudo busybox-suid execline tzdata sqlite-dev && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
EXPOSE 3000
WORKDIR /app

COPY --from=builder /app/vendor/bundle vendor/bundle
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY . /app

#ENTRYPOINT ["docker/rails/entrypoint.sh"]
CMD exec bundle exec puma -C config/puma.rb
