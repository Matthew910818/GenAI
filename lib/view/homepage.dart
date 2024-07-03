import 'package:flutter/material.dart';
import '../viewmodel/viewmodel.dart';
import 'highlight1.dart';
import 'highlight2.dart';
import 'highlight3.dart';

class MyHomePage extends StatelessWidget {
  final viewModel = MyViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: Center(
                child: Text(
                  '觀看賽事',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Image.asset('assets/dunk.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '影片摘要',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                viewModel.videoSummary,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '影片精華',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Column(
              children: [
                // Button1
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstHighlightPage()),
                    );
                  },
                  child: buildButton(viewModel.videoHighlights[0]),
                ),
                SizedBox(height: 10),
                // Button2
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondHighlightPage()),
                    );
                  },
                  child: buildButton(viewModel.videoHighlights[1]),
                ),
                SizedBox(height: 10),
                // Button3
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThirdHighlightPage()),
                    );
                  },
                  child: buildButton(viewModel.videoHighlights[2]),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget buildButton(VideoHighlight highlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(197, 208, 195, 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Image.asset(highlight.imagePath),
          title: Text(
            highlight.title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            highlight.duration,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 49, 5).withOpacity(1), 
                  shape: BoxShape.circle,
                ),
              ),
              Icon(Icons.play_arrow, color: Color.fromARGB(255, 92, 227, 96)),
            ],
          ),
          tileColor: Colors.transparent,
        ),
      ),
    );
  }
}
