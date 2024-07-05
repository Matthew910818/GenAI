from utils import read_video, save_video
from trackers import Tracker
from team_assigner import TeamAssigner
import os
jersey_number_table = {
    2 : '25',
    3 : '21',
    7 : '4',
    4 : '14',
    11 : '2',
    5 : '45',
    9 : '10',
    1 : '26',
    10 : '4',
    8 : '24',
    6 : '19'
}

# Read Video
video_frames = read_video('/home/shen/Documents/ELTA_Contest/football_analysis/input_videos/football5_3.mov')

# Initialize Tracker
tracker = Tracker('models/best.pt')

tracks = tracker.get_object_tracks(video_frames,
                                    read_from_stub=True,
                                    stub_path='stubs/track_stubs.pkl')

# Get object positions 
tracker.add_position_to_tracks(tracks)

# Assign Player Teams
team_assigner = TeamAssigner()
team_assigner.assign_team_color(video_frames[0], 
                                tracks['players'][0])

for frame_num, player_track in enumerate(tracks['players']):
    for player_id, track in player_track.items():
        team = team_assigner.get_player_team(video_frames[frame_num],   
                                                track['bbox'],
                                                player_id)
        tracks['players'][frame_num][player_id]['team'] = team 
        tracks['players'][frame_num][player_id]['team_color'] = team_assigner.team_colors[team]


output_video_frames = tracker.draw_annotations(video_frames, tracks, jersey_number_table)

# Save video
save_video(output_video_frames, 'output_videos/football.avi')
# Convert the saved video to mp4 using ffmpeg
os.system("ffmpeg -y -i output_videos/football.avi output_videos/football.mp4")

