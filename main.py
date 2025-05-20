from kivy.app import App
from kivy.uix.button import Button
import spotipy
from spotipy.oauth2 import SpotifyOAuth
import os

CLIENT_ID = os.getenv("SPOTIPY_CLIENT_ID")
CLIENT_SECRET = os.getenv("SPOTIPY_CLIENT_SECRET")
REDIRECT_URI = "http://localhost:8888/callback/"

class LikedSongsApp(App):
    def build(self):
        return Button(text='Backup Liked Songs', on_press=self.backup_songs)

    def backup_songs(self, instance):
        sp = spotipy.Spotify(auth_manager=SpotifyOAuth(
            client_id=CLIENT_ID,
            client_secret=CLIENT_SECRET,
            redirect_uri=REDIRECT_URI,
            scope="user-library-read playlist-modify-public"
        ))
        user_id = sp.current_user()['id']
        playlist = sp.user_playlist_create(user=user_id, name='Liked Songs Backup')
        liked = sp.current_user_saved_tracks(limit=50)
        tracks = [item['track']['id'] for item in liked['items']]
        sp.playlist_add_items(playlist['id'], tracks)
        instance.text = f'Added {len(tracks)} tracks!'

LikedSongsApp().run()