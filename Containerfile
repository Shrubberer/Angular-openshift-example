# Import the base image as UBI-Nodejs 18 image
FROM registry.access.redhat.com/ubi8/nodejs-18:1-71.1695741533

# Set the working directory to /project
WORKDIR /project

# Copy package files in container currunt direcctory
#we could also do COPY . . 
COPY --chown=1001:1001 package.json package-lock.json ./

# needed for npm run build
ENV NG_CLI_ANALYTICS=false

# Install all Angular dependacies
# Changed ci to install
RUN npm install

# Add application files in container 
COPY . .
RUN npm run build

# Set permision of .angular file in container
VOLUME ["/project/.angular"]

# Open port to allow traffic in container
EXPOSE 8080

# Run start script using npm command
CMD ["npm", "start"]
