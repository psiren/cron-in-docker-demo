FROM alpine

LABEL maintainer="marshal.psi@gmail.com"

COPY ./cron_tasks/periodic /etc/periodic

COPY ./scripts/startup.sh /usr/local/startup.sh

ENTRYPOINT ["/usr/local/startup.sh"]
