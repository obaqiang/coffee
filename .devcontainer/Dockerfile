# Specify the base image you want your dev container to use.
# You may use the same exact base image your application would use in production for consistancy.
# That could prevent surprises such as "works in local, but not in PROD".

FROM node:14.17.0-alpine

# Additionally you can install other dependencies for the environment while configuring the base image.
# In this example, I am installing Git as the Alpine version of node does not come with one. 

RUN apk update
RUN apk add git