FROM alpine

# Installs latest Chromium (100) package.
RUN apk add --no-cache \
	chromium \
	nss \
	freetype \
	harfbuzz \
	ca-certificates \
	ttf-freefont \
	nodejs \
	npm

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
	PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

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
