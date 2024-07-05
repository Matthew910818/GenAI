import pickle


def load_tracks_from_file(file_path):
    with open(file_path, 'rb') as f:
        tracks = pickle.load(f)
    return tracks

def get_player_by_frame_and_point(frame_num, point, tracks_file_path):

    tracks = load_tracks_from_file(tracks_file_path)
    

    if frame_num < 0 or frame_num >= len(tracks['players']):
        return None
    
    x, y = point


    for player_id, track in tracks['players'][frame_num].items():
        bbox = track['bbox']
        x1, y1, x2, y2 = bbox


        if x1 <= x <= x2 and y1 <= y <= y2:
            return track
    
    return None
