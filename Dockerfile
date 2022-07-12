FROM node:16-alpine3.15

RUN apk add --no-cache \
	chromium \
	ca-certificates

# This is to prevent the build from getting stuck on "Taking snapshot of full filesystem"
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true 

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .

# Needed because we set PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
# ENV SCULLY_PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser

# build_prod_scully is set in package.json to: "ng build --configuration=production && yarn scully --scanRoutes"
EXPOSE 5000
CMD ["npm", "start"]
# RUN npm start