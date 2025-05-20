FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    python3-setuptools \
    git \
    curl \
    unzip \
    build-essential \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    liblzma-dev \
    libbz2-dev \
    pkg-config \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install cython buildozer

ENV ANDROID_SDK_ROOT=/opt/android-sdk

RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
WORKDIR $ANDROID_SDK_ROOT/cmdline-tools
RUN curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip commandlinetools.zip && rm commandlinetools.zip

RUN mv cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest

ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

RUN yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT --licenses

RUN sdkmanager --sdk_root=$ANDROID_SDK_ROOT \
    "platform-tools" \
    "platforms;android-33" \
    "build-tools;33.0.2" \
    "ndk;25.2.9519653" \
    "cmake;3.22.1" \
    "ndk-bundle"

RUN useradd -m buildozer
USER buildozer
WORKDIR /home/buildozer/app

CMD ["buildozer", "android", "debug"]
