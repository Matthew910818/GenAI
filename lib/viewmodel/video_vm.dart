// viewmodel/video_viewmodel.dart
import '../model/video.dart';
import '../repository/video_repo.dart';

class VideoViewModel {
  final VideoRepository _repository = VideoRepository();
  late Video video;
  late List<Video> videoHighlights;
  late List<Video> similarVideos;
  late List<Video> recommendedVideos;
  late List<Video> allVideos ; 

  VideoViewModel() {
    _loadVideo();
    _loadAllVideos();
    _loadVideoHighlights();
    _loadSimilarVideos();
    _loadRecommendedVideos();
  }

  Future<void> _loadAllVideos() async {
    allVideos = await _repository.parseVideos("assets/channel_videos.json");
  }

  Future<void> loadVideos() async {
    video = await _repository.fetchVideo();
    videoHighlights = await _repository.fetchVideoHighlights();
    similarVideos = await _repository.fetchSimilarVideos();
    recommendedVideos = await _repository.fetchRecommendedVideos();
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

  void _loadRecommendedVideos() {
    similarVideos = _repository.fetchRecommendedVideos();
  }

}
