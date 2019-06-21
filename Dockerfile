FROM debian:stretch

ENV SSH_PUB="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Nxmmf2RSv1yWRuAfrStRlqR2GKOM9Fbzz9buc4UBsalBtm00A+a+Meq9UhaAYsZEi2CY+K5QsW4KIQ59K6RZ3bVgnJgNT+BBFEeonsalc8xyrRtnFWF1PlZMbMuAw5BCGxKKPwQKpLt4sk4qtD4aO5qGZFN7LKMXVQ+aLAriRnps8GpQCK5/wZk3+sytEj6oyOxTDzrhWPs41yqtvwaHneLZz8N8ZO/igDW+EufIBN1LggLnjjlt4zjzeE3h525nxY18Z4L9bXlC4hb5pkMrmjiYTRKDzROlmo+huM38rJJBlcYG8Fv5TyHBnuEvV9NcrdS68F9ZhGD7dLi9Z9tn docker_ssh"

RUN apt-get update && \
    apt-get -y install openssh-server && \
    apt-get clean all -y

# manage sshd config
RUN sed -i 's/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g' /etc/ssh/sshd_config  && \
    sed -i 's/PermitRootLogin */PermitRootLogin without-password/' /etc/ssh/sshd_config

# manage ssh keys
## root
RUN [[ ! (( -d /root/.ssh )) ]] && mkdir -p /root/.ssh )) && \
    chown root:root /root/.ssh && \
    chmod 0700 /root/.ssh && \
    echo $SSH_PUB > /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd" "-D"]
