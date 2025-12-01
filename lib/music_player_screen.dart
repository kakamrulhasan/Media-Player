import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

 final List<Song> _playlist = [
  Song(
    songName: 'Test Song',
    artiestName: 'MP3',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    durationSecond: 343,
  ),

  Song(
    songName: 'Short Music 2',
    artiestName: 'MP3',
    songUrl:
        'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Kevin_MacLeod/Calming/Kevin_MacLeod_-_Clean_Soul.mp3',
    durationSecond: 25,
  ),
  Song(
    songName: 'Test Song',
    artiestName: 'MP3',
    songUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    durationSecond: 348,
  ),
  Song(
    songName: 'Another Short Music',
    artiestName: 'MP3',
    songUrl:
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    durationSecond: 325,
  ),
  Song(
    songName: 'SoundHelix Song 1',
    artiestName: 'SoundHelix',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    durationSecond: 343,
  ),
  Song(
    songName: 'SoundHelix Song 2',
    artiestName: 'SoundHelix',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    durationSecond: 348,
  ),
  Song(
    songName: 'SoundHelix Song 3',
    artiestName: 'SoundHelix',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    durationSecond: 325,
  ),
  Song(
    songName: 'SoundHelix Song 4',
    artiestName: 'SoundHelix',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    durationSecond: 356,
  ),
  Song(
    songName: 'SoundHelix Song 5',
    artiestName: 'SoundHelix',
    songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    durationSecond: 330,
  ),
];

  int _currentIndex = 0;
  bool _isPlaying = false;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _listenToPlayer();
    playSong(_currentIndex);
  }

  void _listenToPlayer() {
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _audioPlayer.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() => _isPlaying = state == PlayerState.playing);
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      next();
    });
  }

  Future<void> playSong(int index) async {
    _currentIndex = index;
    final Song song = _playlist[index];

    setState(() {
      _position = Duration.zero;
      _duration = Duration(seconds: song.durationSecond);
    });

    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(song.songUrl));
  }

  Future<void> next() async {
    final int nextIndex = (_currentIndex + 1) % _playlist.length;
    await playSong(nextIndex);
  }

  Future<void> previous() async {
    final int prevIndex =
        (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(prevIndex);
  }

  Future<void> _togglePlayer() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final Song song = _playlist[_currentIndex];

    final double maxSeconds = max(_duration.inSeconds.toDouble(), 1);
    final double currentSeconds =
        _position.inSeconds.toDouble().clamp(0, maxSeconds);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Music App")),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// --- SONG PLAYING CARD ---
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(song.songName,
                        style:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(song.artiestName),

                    // --- SLIDER ---
                    Slider(
                      min: 0,
                      max: maxSeconds,
                      value: currentSeconds,
                      onChanged: (value) {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                    ),

                    // --- TIME ROW ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(_position)),
                        Text(formatDuration(_duration)),
                      ],
                    ),

                    // --- PLAYER BUTTONS ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: previous,
                          icon: const Icon(Icons.skip_previous),
                        ),

                        IconButton(
                          onPressed: _togglePlayer,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          iconSize: 40,
                        ),

                        IconButton(
                          onPressed: next,
                          icon: const Icon(Icons.skip_next),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- PLAYLIST ---
            Expanded(
              child: ListView.builder(
                itemCount: _playlist.length,
                itemBuilder: (context, index) {
                  final Song s = _playlist[index];
                  final bool isCurrent = index == _currentIndex;

                  return ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(s.songName),
                    subtitle: Text(s.artiestName),
                    trailing: Icon(
                      isCurrent
                          ? (_isPlaying ? Icons.pause : Icons.play_arrow)
                          : Icons.play_arrow,
                    ),
                    selected: isCurrent,
                    onTap: () => playSong(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
