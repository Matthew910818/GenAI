import '../model/video.dart';
import '../repository/video_repo.dart';

class VideoViewModel {
  final VideoRepository _repository = VideoRepository();
  late Video video;
  late List<Video> videoHighlights;
  late List<Video> similarVideos;
  late List<Video> recommendedVideos;
  late Future<Map<String, List<Video>>> categorizedVideos; 

  VideoViewModel() {
    _loadVideo();
    categorizedVideos = _loadCategoryVideos();
    _loadVideoHighlights();
    _loadSimilarVideos();
    _loadRecommendedVideos();
  }

  Future<Map<String, List<Video>>> _loadCategoryVideos() async {
    final categorizedVideos = await _repository.parseCategoryVideos("categorized_videos.json");
    return categorizedVideos;
  }

  Future<void> loadVideos() async {
    video = _repository.fetchVideo();
    videoHighlights = _repository.fetchVideoHighlights();
    similarVideos = _repository.fetchSimilarVideos();
    recommendedVideos = _repository.fetchRecommendedVideos();
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
