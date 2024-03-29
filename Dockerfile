ARG BUILDER_DOCKER_REGISTRY="docker.io/library"
ARG SERVER_DOCKER_REGISTRY="ghcr.io/nginxinc"

################## builder ##################
FROM $BUILDER_DOCKER_REGISTRY/node:21-slim AS builder
SHELL ["/bin/bash", "-c"]
WORKDIR /project
USER 0

COPY .npmrc ./
ARG NPM_REGISTRY="https://registry.npmjs.org"

RUN sed -i s+NPM_REGISTRY+$NPM_REGISTRY+g .npmrc \
    && mkdir -p /usr/etc \
    && cp .npmrc /usr/etc/npmrc \
    && npm install -g "pnpm@v8.15.1"

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY app app

COPY tsconfig.json \
    vite.config.ts \
    vite.tsconfig.json \
    .eslintrc.json \
    .prettierrc.json \
    ./

RUN bash -c \
    'if [[ "$build_env" == "dev" ]]; then \
        npm run build:dev; \
    else \
        npm run build; \
    fi'

################## server ##################
FROM $SERVER_DOCKER_REGISTRY/nginx-unprivileged:1.25.3-alpine-slim AS server
COPY server/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /project/build /usr/share/nginx/html
