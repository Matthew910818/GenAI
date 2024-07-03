class MyViewModel {
  String get videoSummary => 'NBA總冠軍賽今天舉行關鍵第四戰，前三戰飽受戰敗陰影的獨行俠已經沒有退路，台灣時間今天（15日）靠著東契奇（Luka Doncic）及厄文（Kyrie Irving）合力進帳50分，最終以122比84大勝塞爾蒂克，將決賽戰線拉到第五場，也免於在主場看對手慶功。';

  List<VideoHighlight> get videoHighlights => [
        VideoHighlight('assets/dunk.png', '快攻爆扣', '04:30'),
        VideoHighlight('assets/crossover.png', '精彩過人', '06:00'),
        VideoHighlight('assets/last.jpeg', '關鍵絕殺', '09:30'),
      ];
}

class VideoHighlight {
  final String imagePath;
  final String title;
  final String duration;

  VideoHighlight(this.imagePath, this.title, this.duration);
}
