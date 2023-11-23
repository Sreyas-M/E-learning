import 'package:flutter/material.dart';

class VideoSection extends StatelessWidget {
  final String author, topicfir, topicsec, topicthird, topicfour;

  VideoSection({
    required this.author,
    required this.topicfir,
    required this.topicsec,
    required this.topicthird,
    required this.topicfour,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        buildVideoItem(topicfir),
        buildVideoItem(topicsec),
        buildVideoItem(topicthird),
        buildVideoItem(topicfour),
      ],
    );
  }

  Widget buildVideoItem(String title) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue, // Customize the color as needed
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(title),
      subtitle: Text(author),
    );
  }
}
