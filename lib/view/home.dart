import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:genai_v2/view/homepage.dart';
import 'package:video_player/video_player.dart';
import '../viewmodel/video_vm.dart';
import '../model/video.dart';
import 'highlight.dart';
import '../view/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  final viewModel = VideoViewModel();
  bool isLoading = true;
  late List<VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await viewModel.loadVideos();
    _controllers = viewModel.videoHighlights
        .map((video) => VideoPlayerController.network(video.videoPath))
        .toList();
    for (var controller in _controllers) {
      await controller.initialize();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 30, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 30, 30),
        elevation: 20,
        centerTitle: true,
        title: Text(
          '愛爾達',
          style: TextStyle(
            // fontFamily: 'Roboto',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: _controllers.map((controller) {
                          return Container(
                            width: constraints.maxWidth,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      _buildRecommendedVideoSection(constraints),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildRecommendedVideoSection(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 600,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.recommendedVideos.length,
              itemBuilder: (context, index) {
                final video = viewModel.recommendedVideos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MyHomePage()),
                    );
                  },
                  child: _buildRecommendCard(video),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendCard(Video video) {
    return Container(
      width: double.infinity,
      height: 100.0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF2C2F33), // Dark background color for the cards
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            video.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          video.title,
          style: TextStyle(
            // fontFamily: 'Roboto',
            fontSize: 20,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
