FROM alpine:3.11

LABEL MAINTAINER cheimke@loumaris.com

RUN apk --update add  python3 openssl ca-certificates ruby \
                      python3-dev libffi-dev openssl-dev build-base \
                      sshpass openssh-client rsync curl git  \
                      py-dnspython py-boto py-netaddr && \
    rm -rf /var/cache/apk/*   && \
    mkdir -p /etc/ansible     && \
    echo 'localhost' > /etc/ansible/hosts

RUN pip3 install --upgrade pip cffi pywinrm  ansible==2.9.1 yq mitogen && \
    gem install rake

WORKDIR /ansible/playbooks

VOLUME [ "/ansible/playbooks" ]

CMD [ "ansible-playbook", "--version" ]