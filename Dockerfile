FROM node:20-alpine3.19
WORKDIR /app
COPY .profile ~/.profile

RUN apk update && apk add --no-cache \
  build-base \
  vim \
  nano \
  curl \
  git \
  gnupg \
  jq \
  openssl-dev \
  make \
  unzip \
  wget \
  zip \
  postgresql-client

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
  -p git -p ssh-agent -p 'history-substring-search' \
  -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
  -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down' \
  -t robbyrussell

RUN npm i -g @nestjs/cli

CMD [ "tail", "-f", "/dev/null" ]
