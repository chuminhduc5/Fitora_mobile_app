import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Lấy ID video từ đường link YouTube, ví dụ: https://www.youtube.com/watch?v=dQw4w9WgXcQ
    String videoId = YoutubePlayer.convertUrlToId('https://youtu.be/h2fPDCzNvFo?list=RDh2fPDCzNvFo')!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Tự động phát video khi load
        mute: false,    // Không tắt tiếng
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Giải phóng controller khi không còn sử dụng
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true, // Hiển thị thanh tiến độ
        ),
      ),
    );
  }
}
