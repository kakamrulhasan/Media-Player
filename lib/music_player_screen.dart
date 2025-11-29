import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  @override
  Widget build(BuildContext context) {
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('song name'),
                  subtitle: Text('artiest name'),
                  leading: Text('1'),
                  trailing: Icon(Icons.skip_next),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
