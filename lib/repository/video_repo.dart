import 'dart:convert';
import 'dart:io';
import '../model/video.dart';
import 'package:flutter/services.dart' show rootBundle;

class VideoRepository {
  

  Future<Map<String,List<Video>>> parseCategoryVideos(String filePath) async {
    try {
      final String response = await rootBundle.loadString(filePath);
      final Map<String, dynamic> jsonMap = json.decode(response);

      Map<String,List<Video>> videos = {};
      jsonMap["categories"].forEach((category, videoList) {
        final List<Video> video_lis = [];
        for (var videoJson in videoList) {
          video_lis.add(Video.fromJson(videoJson));
        }

        videos[category] = video_lis ; 
      });

      return videos;
    } catch (e) {
      print('Error reading JSON file: $e');
      return {};
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

  List<Video> fetchSimilarVideos(String videoTitle) {
    print( 'Title : ${videoTitle}' ) ; 
    final recommendlist = [
      new Video(
        title: '2016-17 UEFA 歐洲冠軍聯賽 5/3 皇家馬德里 vs 馬德里競技(四強)',
        imagePath: 'https://i.ytimg.com/vi/0Wk4gd5rqgk/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAhW4lLiQEOgJYlTglnakYKNMLXcQ',
        duration: '1:55:59',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 歐洲冠軍聯賽 - 5/11 馬德里競技 VS 皇家馬德里 (四強賽次回)',
        imagePath: 'https://i.ytimg.com/vi/jKDIfVZO414/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDL_uHY1auPGjmHr2uDHYa2W13KSg',
        duration: '2:00:02',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '【17 18歐冠】0412 皇家馬德里 vs  尤文圖斯 精彩花絮',
        imagePath: 'https://i.ytimg.com/vi/agzuw04u54U/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDsXeGczJD82UitwRV00jGgjvxIUA',
        duration: '2:55',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 歐洲冠軍聯賽 - 5/10 尤文圖斯 VS 摩納哥 (四強賽次回)',
        imagePath: 'https://i.ytimg.com/vi/ehGG16wurRg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLD2UZXANEpVQlhe3n9hRkEufSGK0g',
        duration: '1:59:09',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 UEFA 歐洲冠軍聯賽 11/2 巴塞爾 VS 巴黎聖日耳曼',
        imagePath: 'https://i.ytimg.com/vi/esIWws1N7kA/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBuVKKmfHLJiE1QU4jYG_gKHeDImQ',
        duration: '1:46:19',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 UEFA 歐洲冠軍聯賽 09/14 巴黎聖日耳曼 VS 兵工廠',
        imagePath: 'https://i.ytimg.com/vi/jf9P-2brqik/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCCz87AzXPEfoojJqUqIKB68yIIjA',
        duration: '1:58:28',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 UEFA 歐洲冠軍聯賽 09/29 盧多格雷玆 vs 巴黎聖日耳曼',
        imagePath: 'https://i.ytimg.com/vi/W6PooHxE0BQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDTBh_TbWGgXbjT7YUkcuqjFHr19Q',
        duration: '1:48:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      ),
      new Video(
        title: '2016-17 UEFA歐洲冠軍聯賽 09/29 盧多格雷玆 vs 巴黎聖日耳曼',
        imagePath: 'https://i.ytimg.com/vi/UrCYzBPsLPk/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCC8I0ZIsvvsqqiAbq4BM_6TPOMkQ',
        duration: '1:48:00',
        videoPath: 'assets/football.mp4',
        summary: 'This is a summary'
      )
    ];
    if (videoTitle == "Home"){
      return recommendlist.sublist(0,4);

    }else if(videoTitle == "Full Video Title")
    {
      return recommendlist.sublist(4,8);
    }
    else return recommendlist.sublist(4,8);

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
