FROM ubuntu:18.04
MAINTAINER wahaha00 wahaha00@qq.com
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y net-tools
COPY index.html /usr/share/nginx/html/
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
