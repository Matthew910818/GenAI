from utils import read_video, save_video
from trackers import Tracker
from team_assigner import TeamAssigner
import os
jersey_number_table = {
    "12" : "10",
    "11" : "4",
    "6" : "14",
    "4" : "2",
    "1" : "23",
    "28" : "5",
    "17" : "11",
    "9" : "25",
    "8" : "5",
    "10" : "6",
    "5" : "9",
    "2" : "12",
    "7" : "20",
    "13" : "14",
    "15" : "1"
}

# Read Video
video_frames = read_video('/home/shen/Documents/ELTA_Contest/football_analysis/input_videos/game2/clip_1_no_circle.mp4')

# Initialize Tracker
tracker = Tracker('/home/shen/Documents/ELTA_Contest/best.pt')

tracks = tracker.get_object_tracks(video_frames,
                                    read_from_stub=True,
                                    stub_path='/home/shen/Documents/ELTA_Contest/football_analysis/stubs/track_stubs.json')

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


output_video_frames = tracker.draw_annotations(video_frames, tracks, jersey_number_table, "/home/shen/Documents/ELTA_Contest/football_analysis/stubs/track_stubs.json")

# Save video
save_video(output_video_frames, '/home/shen/Documents/ELTA_Contest/football_analysis/output_videos/football.avi')
# Convert the saved video to mp4 using ffmpeg
os.system("ffmpeg -y -i /home/shen/Documents/ELTA_Contest/football_analysis/output_videos/football.avi /home/shen/Documents/ELTA_Contest/football_analysis/output_videos/game2/clip_1.mp4")

