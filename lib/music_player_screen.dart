import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/model.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Song> _playlist = [
    Song(
      songName: 'sample1',
      artiestName: 'No Name',
      songUrl: '//samplelib.com/lib/preview/mp3/sample-3s.mp3',
      durationSecond: 3,
    ),
    Song(
      songName: 'sample2',
      artiestName: 'No Name',
      songUrl: '//samplelib.com/lib/preview/mp3/sample-3s.mp3',
      durationSecond: 3,
    ),
    Song(
      songName: 'sample3',
      artiestName: 'No Name',
      songUrl: '//samplelib.com/lib/preview/mp3/sample-3s.mp3',
      durationSecond: 3,
    ),
    Song(
      songName: 'sample4',
      artiestName: 'No Name',
      songUrl: '//samplelib.com/lib/preview/mp3/sample-3s.mp3',
      durationSecond: 3,
    ),
  ];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    _listenToPlayer();
    super.initState();
  }

  void _listenToPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() => _isPlaying = state == PlayerState.playing);
    });
    _audioPlayer.onPlayerComplete.listen((_) => next());
  }

  Future<void> playSong(int index) async {
    _currentIndex = index;
    final song = _playlist[index];
    setState(() {
      _position = Duration.zero;
      _duration = Duration(seconds: song.durationSecond);
    });
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(_playlist[index].songUrl));
  }

  Future<void> next() async {
    final int next = (_currentIndex + 1) % _playlist.length;
    await playSong(next);
  }

  Future<void> previous() async {
    final int previous =
        (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(previous);
  }

  Future<void> _togglePlayer() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  String formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int second = duration.inSeconds.remainder(60);
    return '$minutes: ${second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final Song song = _playlist[_currentIndex];
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Music App'))),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text('Song title'),
                Text('Artiest name'),

                Slider(value: 0, onChanged: (ValueKey) {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('current Time'), Text('total duration')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.skip_previous),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),

                    IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final Song song = _playlist[index];
                return ListTile(
                  title: Text(song.songName),
                  subtitle: Text(song.artiestName),
                  leading: Text("${_playlist[index]}"),
                  trailing: Icon(Icons.skip_next),
                  onTap: () => playSong(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
