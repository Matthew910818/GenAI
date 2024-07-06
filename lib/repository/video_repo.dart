// repository/video_repo.dart
import '../model/video.dart';

class VideoRepository {
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
      summary: 'This is a sample summary of the main video.',
    );
  }
}
