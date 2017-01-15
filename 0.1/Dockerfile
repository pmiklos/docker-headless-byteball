FROM node:7.4-alpine

RUN	deluser --remove-home node \
	&& adduser -D -u 1000 byteball \
	&& apk add --no-cache --virtual .build-deps \
		curl \
		unzip \
	&& curl -SL -o headless-byteball.zip https://github.com/byteball/headless-byteball/archive/master.zip \
	&& unzip headless-byteball.zip \
	&& cd headless-byteball-master/ \
	&& npm install -g \
	&& cd ..  \
	&& rm -rf headless-byteball-master \
	&& rm headless-byteball.zip \
	&& apk del .build-deps \
	&& mkdir /byteball /home/byteball/.config \
	&& chown byteball:byteball /byteball /home/byteball/.config \
	&& ln -s /byteball /home/byteball/.config/headless-byteball

VOLUME /byteball

USER byteball
WORKDIR /home/byteball

EXPOSE 6611 6332

CMD ["node", "/usr/local/lib/node_modules/headless-byteball/start.js"]
