FROM ubuntu:22.04 as base
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /usr/local/bin
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS user
RUN addgroup --gid 1000 maxi
RUN adduser --gecos maxi --uid 1000 --gid 1000 --disabled-password maxi
USER maxi
WORKDIR /home/maxi

FROM user
COPY . .
CMD ["sh", "-c", "ansible-playbook --tags install local.yml"]