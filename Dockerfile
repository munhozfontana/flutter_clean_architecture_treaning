#Stage 1 - Install dependencies and build the app
FROM debian:stable AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Run flutter doctor and set path
RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web
# Copy files to container and build
WORKDIR  /usr/local/app
COPY . /usr/local/app
RUN /usr/local/flutter/bin/flutter packages upgrade
RUN /usr/local/flutter/bin/flutter test test
RUN /usr/local/flutter/bin/flutter build web --release --csp

# Stage 2 - Create the run-time image
FROM nginx
COPY --from=build-env /usr/local/app/build/web /usr/share/nginx/html