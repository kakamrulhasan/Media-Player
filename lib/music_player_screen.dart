import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/theme_provider.dart';
import 'package:provider/provider.dart';
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
      songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      durationSecond: 348,
    ),
    Song(
      songName: 'Another Short Music',
      artiestName: 'MP3',
      songUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
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
    final double currentSeconds = _position.inSeconds.toDouble().clamp(
      0,
      maxSeconds,
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Music App")),

        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Switch(
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// --- ALBUM ART + GLASSMORPHISM CARD ---
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white24, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Album Art with subtle shadow
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.4),
                              blurRadius: 25,
                              spreadRadius: 1,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://picsum.photos/300?random=$_currentIndex",
                            height: 220,
                            width: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Song Info
                      Text(
                        song.songName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        song.artiestName,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),

                      const SizedBox(height: 16),

                      // Slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 16,
                          ),
                          trackHeight: 3,
                          thumbColor: Theme.of(context).colorScheme.primary,
                          activeTrackColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          inactiveTrackColor: Colors.white24,
                        ),
                        child: Slider(
                          min: 0,
                          max: maxSeconds,
                          value: currentSeconds,
                          onChanged: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(_position),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            formatDuration(_duration),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Player Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 36,
                            onPressed: previous,
                            icon: const Icon(Icons.skip_previous_rounded),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: IconButton(
                              iconSize: 36,
                              onPressed: _togglePlayer,
                              icon: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 36,
                            onPressed: next,
                            icon: const Icon(Icons.skip_next_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- PLAYLIST TITLE ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Playlist",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              // --- PLAYLIST (Modern List) ---
              Expanded(
                child: ListView.builder(
                  itemCount: _playlist.length,
                  itemBuilder: (context, index) {
                    final s = _playlist[index];
                    final isCurrent = index == _currentIndex;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.2)
                            : Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: isCurrent
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.5,
                              )
                            : Border.all(color: Colors.white10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.7),
                          child: Text(
                            "${index + 1}", // show 1, 2, 3...
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        title: Text(s.songName),
                        subtitle: Text(
                          s.artiestName,
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Icon(
                          isCurrent
                              ? (_isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded)
                              : Icons.play_arrow_rounded,
                        ),
                        onTap: () => playSong(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
