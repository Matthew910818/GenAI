// repository/video_repo.dart
import 'dart:convert';
import 'dart:io';

import '../model/video.dart';

class VideoRepository {

Future<List<Video>> parseVideos(String filePath) async {
    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map<Video>((videoJson) => Video.fromJson(videoJson as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error reading JSON file: $e');
      return [];
    }
  }



  List<Video> fetchVideoHighlights() {
    // Simulate fetching data from an external source
    return [
      Video(
        title: 'Highlight 1',
        imagePath: 'assets/crossover.png',
        duration: '00:30',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Highlight 1',
      ),
      Video(
        title: 'Highlight 2',
        imagePath: 'assets/crossover.png',
        duration: '00:45',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Highlight 2',
      ),
      Video(
        title: 'Highlight 3',
        imagePath: 'assets/crossover.png',
        duration: '01:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Highlight 3',
      ),
    ];
  }

  List<Video> fetchSimilarVideos() {
    // Simulate fetching data from an external source
    return [
      Video(
        title: 'Similar Video 1',
        imagePath: 'assets/crossover.png',
        duration: '02:00',
      
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 1',
      ),
      Video(
        title: 'Similar Video 2',
        imagePath: 'assets/crossover.png',
        duration: '01:30',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 2',
      ),
      Video(
        title: 'Similar Video 3',
        imagePath: 'assets/crossover.png',
        duration: '03:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 3',
      ),
    ];
  }

  List<Video> fetchRecommendedVideos() {
    // Simulate fetching data from an external source
    return [
      Video(
        title: 'Recommended Video 1',
        imagePath: 'assets/crossover.png', 
        duration: '03:00', 
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 1',
      ),
      Video(
        title: 'Recommended Video 2',
        imagePath: 'assets/crossover.png',
        duration: '03:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 2',
      ),
      Video(
        title: 'Recommended Video 3',
        imagePath: 'assets/crossover.png',
        duration: '03:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 3',
      ),
      Video(
        title: 'Recommended Video 4',
        imagePath: 'assets/crossover.png',
        duration: '03:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 4',
      ),
      Video(
        title: 'Recommended Video 5',
        imagePath: 'assets/crossover.png',
        duration: '03:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary for Similar Video 5',
      ),
    ];
  }

  Video fetchVideo() {
    // Simulate fetching a single video from an external source
    return Video(
      title: 'Main Video',
      imagePath: 'assets/crossover.png',
      duration: '10:00',
      videoPath: 'assets/football.mp4',
      summary: """In this exciting UEFA Champions League final, Real Madrid and Juventus presented the audience with an unforgettable match. From the beginning, both teams displayed a high level of competitiveness. Juventus created three threatening shots within the first five minutes, but Real Madrid's goalkeeper Keylor Navas successfully saved them all.

In the 20th minute, Real Madrid's Cristiano Ronaldo (CR7) received a pass from Benzema and quickly scored in the penalty area, giving Real Madrid the lead. This goal showcased Ronaldo's sharp instincts and strong shooting ability. However, just seven minutes later, Juventus' Mario Mandzukic equalized with a stunning bicycle kick, which not only demonstrated high technical skill but also greatly boosted Juventus' morale.

At the end of the first half, the teams were tied 1-1. After the start of the second half, both sides maintained a high-intensity pace. Real Madrid gradually took control of the game and in the 61st minute of the second half, Casemiro scored from a long shot to regain the lead. Shortly after, in the 64th minute, Ronaldo scored again, extending the lead to 3-1.

Juventus attempted to fight back, but their efforts were in vain. Instead, they conceded another goal in the 90th minute by Asensio, sealing the victory. In the end, Real Madrid defeated Juventus 4-1, successfully defending their Champions League title, marking their 12th Champions League trophy in the club's history. In this match, Ronaldo not only scored twice but also demonstrated his decisive impact in crucial moments, further solidifying his legendary status in European football.

The match was full of intense confrontations and brilliant moments. Both the tactical arrangements and individual technical performances provided the audience with immense visual enjoyment. Despite the defeat, Juventus' fighting spirit was equally commendable. This match once again proved the charm and influence of the UEFA Champions League as the world's top football competition.""",
    );
  }

  
}
