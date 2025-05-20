# Spotify Liked Songs to Playlist App

## How to Use (on Android with Termux)
1. Open Termux and run:

   pkg update && pkg upgrade
   pkg install python git zip unzip clang libffi openssl freetype libpng libjpeg-turbo
   pip install --upgrade pip setuptools wheel
   pip install Cython virtualenv
   pip install buildozer
   termux-setup-storage

2. Unzip this folder and `cd` into it:

   cd ~/storage/downloads/spotify-liked-to-playlist-app

3. Set your Spotify credentials:

   export SPOTIPY_CLIENT_ID='your-client-id'
   export SPOTIPY_CLIENT_SECRET='your-client-secret'

4. Build the app:

   buildozer -v android debug

5. Install the APK:

   termux-open bin/*.apk