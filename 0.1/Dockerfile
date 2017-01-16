FROM node:7.4-alpine

RUN	deluser --remove-home node \
	&& adduser -D -u 1000 byteball \
	&& npm install -g headless-byteball \
	&& mkdir /byteball /home/byteball/.config \
	&& chown byteball:byteball /byteball /home/byteball/.config \
	&& ln -s /byteball /home/byteball/.config/headless-byteball

VOLUME /byteball

USER byteball
WORKDIR /home/byteball

EXPOSE 6611 6332

CMD ["node", "/usr/local/lib/node_modules/headless-byteball/start.js"]

