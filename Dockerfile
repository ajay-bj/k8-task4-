FROM alpine as HUGO

ENV HUGO_VERSION="0.81.0"
RUN apk add --update wget
COPY hugo /bin/hugo
RUN chmod +x /bin/hugo
COPY . /hugo-site
RUN hugo -v --source=/hugo-site --destination=/hugo-site/public
FROM bitnami/nginx:latest
COPY --from=HUGO /hugo-site/public/ /opt/bitnami/nginx/html/
EXPOSE 8080
