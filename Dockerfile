FROM node:21-slim AS base
SHELL ["/bin/bash", "-c"]
WORKDIR /project

RUN npm install -g "pnpm@v8.10.5"
COPY .npmrc package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY app app

################## builder ##################
FROM base AS builder
COPY tsconfig.json \
    vite.config.ts \
    vite.tsconfig.json \
    .eslintrc.json \
    .prettierrc.json \
    ./
RUN bash -c 'if [[ "$build_env" == "dev" ]]; then npm run build:dev; else npm run build; fi'

################## server ##################
FROM nginxinc/nginx-unprivileged:1.25-alpine-slim AS server
COPY server/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /project/build /usr/share/nginx/html
