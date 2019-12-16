FROM node:8.16

RUN	deluser --remove-home node \
	&& adduser -u 1000 obyte \
	&& mkdir /obyte /home/obyte/.config \
	&& chown obyte:obyte /obyte /home/obyte/.config \
	&& ln -s /obyte /home/obyte/.config/headless-obyte

USER obyte
WORKDIR /home/obyte

ARG COMMIT=HEAD

RUN	git clone https://github.com/byteball/headless-obyte.git \
	&& cd headless-obyte \
	&& git checkout ${COMMIT} \
	&& npm install

COPY --chown=obyte:obyte config/ .config/headless-obyte/

VOLUME /obyte

EXPOSE 6611 6332

CMD ["node", "headless-obyte/start.js"]

