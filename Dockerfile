FROM linuxserver/code-server

# expose dev ports
EXPOSE 8000
EXPOSE 3824

# Install NPM and Yarn

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt install -y  nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN sudo apt install -y  yarn

# Install Gatsby Cli
RUN npm install -g gatsby-cli

# Install Flutter - confirm prereq

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Prepare Android directories and system variables

RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/Android/sdk/platform-tools"

# Download Flutter SDK

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/flutter/bin"
