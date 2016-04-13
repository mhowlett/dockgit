FROM ubuntu:14.04

RUN apt-get -qq update \
    && apt-get -qqy install \
    curl \
    emacs \
    git \
    openssh-server \
    wget

RUN useradd -ms /bin/bash git \
    && cd /home/git \
    && mkdir .ssh

COPY authorized_keys /home/git/.ssh/authorized_keys
COPY README.md /home/git/

RUN mkdir /var/run/sshd
# A password could be hardcoded with this if we wanted.
# RUN echo 'root:therootpassword' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
