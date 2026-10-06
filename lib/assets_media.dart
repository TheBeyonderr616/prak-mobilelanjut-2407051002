import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart'; // 1. Tambahkan import untuk video_player

class AssetsMediaPage extends StatefulWidget {
  const AssetsMediaPage({super.key});

  @override
  State<AssetsMediaPage> createState() => _AssetsMediaPageState();
}

class _AssetsMediaPageState extends State<AssetsMediaPage> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  
  // 2. Deklarasikan controller untuk video
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // 3. Inisialisasi video dengan file skele.mp4 milik Anda
    _videoController = VideoPlayerController.asset('assets/videos/skele.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void playAudio() async {
    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(
        AssetSource('audio/music.mp3'),
      );
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    player.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        title: const Text('Assets & Media'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        // Tambahkan SingleChildScrollView agar layar bisa di-scroll
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian 1: Profil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/cuking.jpg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Syawal Putra Akbar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bagian 2: Audio
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Audio Motivasi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E0FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                        onPressed: playAudio,
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: LinearProgressIndicator(
                        value: 0.3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.volume_up),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. Bagian 3: Video (TAMBAHAN BARU)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Video Penjelasan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Tampilkan loading jika video belum siap
                    _videoController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                            child: VideoPlayer(_videoController),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                    const SizedBox(height: 15),
                    // Tombol Play/Pause Video
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFE7E0FF),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _videoController.value.isPlaying
                                ? _videoController.pause()
                                : _videoController.play();
                          });
                        },
                        icon: Icon(
                          _videoController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Spasi bawah agar rapi
            ],
          ),
        ),
      ),
    );
  }
}