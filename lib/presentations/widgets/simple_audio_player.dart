import 'package:dmart_android_flutter/presentations/widgets/shimmer/item_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

class SimpleAudioPlayer extends StatefulWidget {
  final String title;
  final String url;

  const SimpleAudioPlayer({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  SimpleAudioPlayerState createState() => SimpleAudioPlayerState();
}

class SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;
  late LockCachingAudioSource _audioSource;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initializeAndPlay();
    _player.durationStream.listen((d) {
      setState(() {
        _duration = d ?? Duration.zero;
        _isLoading = false;
      });
    });
    _player.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  Future<void> _initializeAndPlay() async {
    _audioSource = LockCachingAudioSource(
      Uri.parse(widget.url),
      headers: {"Authorization": "Bearer ${GetStorage().read("token")}"},
    );
    await _player.setAudioSource(_audioSource);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seek(double value) {
    final position = Duration(seconds: value.toInt());
    _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return [if (d.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const ItemLoadingShimmer()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(widget.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
              Slider(
                min: 0.0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds
                    .clamp(0.0, _duration.inSeconds.toDouble())
                    .toDouble(),
                onChanged: (value) {
                  setState(() {
                    _seek(value);
                  });
                },
              ),
              Text(
                "${_formatDuration(_position)} / ${_formatDuration(_duration)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
  }
}

// Future<void> _initializeAndPlay() async {
//   await _player.setUrl(widget.url,headers: {"Authorization": "Bearer ${GetStorage().read("token")}"});
// }
