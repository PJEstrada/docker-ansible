FROM ubuntu:trusty
MAINTAINER Pablo Estrada <pjestradac@gmail.com>

# Prevent dpkg errors
ENV TERM=x-term-256color


RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list


#Install ansible

RUN apt-get update -qy && \
	apt-get install -qy software-properties-common && \
	apt-add-repository -y ppa:ansible/ansible && \
	apt-get update -qy && \
	apt-get install -qy ansible

# Copy baked in playbooks

COPY ansible /ansible

# Add voulme for Ansible Playbooks
Volume /ansible
WORKDIR /ansible
RUN chmod +x /
#Entrypoint
ENTRYPOINT ["ansible-playbook"]
CMD ["site.yml"]