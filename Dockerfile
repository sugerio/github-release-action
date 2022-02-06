FROM debian:11.2
LABEL "repository"="https://github.com/sugerio/github-release-action"
LABEL "maintainer"="Suger Inc"

RUN apt update \
	&& apt -y upgrade \
  && apt install -y hub \
  && apt autoremove \
	&& apt autoclean \
	&& apt clean

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]