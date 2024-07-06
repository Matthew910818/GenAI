import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../viewmodel/video_vm.dart';
import '../model/video.dart';
import 'highlight.dart';
import '../view/video_player.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final viewModel = VideoViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayerSection(),
            _buildVideoSummarySection(),
            Divider(color: Colors.grey[800], thickness: 1),
            _buildVideoHighlightsSection(context),
            Divider(color: Colors.grey[800], thickness: 1),
            _buildSimilarVideosSection(context),
            Divider(color: Colors.grey[800], thickness: 1),
            _buildCommentsSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
       //   Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        'Game',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.cast, color: Colors.white),
          onPressed: () {
            // Handle cast button press
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // Handle notifications
          },
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Handle search
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle, color: Colors.white),
          onPressed: () {
            // Handle account
          },
        ),
      ],
    );
  }

  Widget _buildVideoPlayerSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: VideoPlayerWidget(videoPath: viewModel.video.videoPath),
      ),
    );
  }

  Widget _buildVideoSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.video.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            viewModel.video.summary,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.white70),
                  SizedBox(width: 5),
                  Text(
                    '123K',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.thumb_down, color: Colors.white70),
                  SizedBox(width: 5),
                  Text(
                    '4K',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share, color: Colors.white70),
                  SizedBox(width: 5),
                  Text(
                    'Share',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.download, color: Colors.white70),
                  SizedBox(width: 5),
                  Text(
                    'Download',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.playlist_add, color: Colors.white70),
                  SizedBox(width: 5),
                  Text(
                    'Save',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoHighlightsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Highlights',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          _buildAnimatedVideoList(viewModel.videoHighlights),
        ],
      ),
    );
  }

  Widget _buildSimilarVideosSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Videos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          _buildAnimatedVideoList(viewModel.similarVideos),
        ],
      ),
    );
  }

  Widget _buildAnimatedVideoList(List<Video> videos) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 16 / 9,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder(
          tween: Tween(begin: Offset(0, 100), end: Offset.zero),
          duration: Duration(milliseconds: 500 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, Offset offset, child) {
            return Transform.translate(
              offset: offset,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => HighlightModal(
                  highlight: videos[index],
                  startTime: Duration.zero,
                ),
              );
            },
            child: _buildHighlightCard(videos[index]),
          ),
        );
      },
    );
  }

  Widget _buildHighlightCard(Video video) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2C2F33),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  video.imagePath,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  color: Colors.black54,
                  child: Text(
                    video.duration,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/channel_icon.png'),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Channel Name',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        '123K views • 1 day ago',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10, // Example: number of comments
            itemBuilder: (context, index) {
              return _buildCommentCard();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'This is a sample comment to demonstrate the comment section layout.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
