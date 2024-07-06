// model/video.dart
class Video {
  final String title;
  final String imagePath;
  final String duration;
  final String videoPath;
  final String summary;

  Video({
    required this.title,
    required this.imagePath,
    required this.duration,
    required this.videoPath,
    required this.summary,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] ?? 'No Title',
      imagePath: (json['thumbnails'] != null && json['thumbnails'].isNotEmpty) ? json['thumbnails'][0]['url'] : 'default_image_path',
      duration: json['duration_string'] ?? '0:00',
      videoPath: json['url'] ?? '',
      summary: json['description'] ?? 'No Description',
    );
    
  }

}


