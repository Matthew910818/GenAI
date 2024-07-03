// viewmodel/video_viewmodel.dart
import '../model/video.dart';
import '../repository/video_repo.dart';

class VideoViewModel {
  final VideoRepository _repository = VideoRepository();
  late Video video;
  late List<Video> videoHighlights;
  late List<Video> similarVideos;

  VideoViewModel() {
    _loadVideo();
    _loadVideoHighlights();
    _loadSimilarVideos();
  }

  void _loadVideo() {
    video = _repository.fetchVideo();
  }

  void _loadVideoHighlights() {
    videoHighlights = _repository.fetchVideoHighlights();
  }

  void _loadSimilarVideos() {
    similarVideos = _repository.fetchSimilarVideos();
  }
}
