FROM ubuntu:22.04 as base
WORKDIR /usr/local/bin

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git


FROM base AS user
RUN addgroup --gid 1000 maxi
RUN adduser --gecos maxi --uid 1000 --gid 1000 --disabled-password maxi
USER maxi
WORKDIR /home/maxi

RUN git clone https://github.com/MaximilianMauroner/clean-install.git
RUN bash ./clean-install/prepare
CMD ["sh", "-c", "clean-install/ansible-playbook local.yml"]