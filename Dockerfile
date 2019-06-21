FROM debian:stretch

RUN apt-get update && \
    apt-get -y install openssh-server && \
    apt-get clean all -y

RUN sed -i 's/PermitRootLogin */PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd" "-D"]
