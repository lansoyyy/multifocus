import 'package:flutter/material.dart';
import 'package:multifocus/screens/home_screen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../widgets/text_widget.dart';

class MusicComponent extends StatefulWidget {
  final String videoId;
  const MusicComponent({super.key, required this.videoId});

  @override
  State<MusicComponent> createState() => _MusicComponentState();
}

class _MusicComponentState extends State<MusicComponent> {
  YoutubePlayerController _controller = YoutubePlayerController();

  String musicTitle = '';
  String musicDescription = '';

  bool isCurrentMusicPlaying = false;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: extractVideoIdFromUrl(widget.videoId),
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    _controller.listen((event) {
      setState(() {
        musicTitle = event.metaData.title;
        musicDescription = event.metaData.author;
      });
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextRegular(
                    text: 'Music',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMusicPlaying = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: YoutubePlayer(
                        controller: _controller,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 75,
                          child: TextBold(
                            overFlow: TextOverflow.ellipsis,
                            text: musicTitle,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextBold(
                          text: musicDescription,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                isCurrentMusicPlaying
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isCurrentMusicPlaying = false;
                          });

                          _controller.pauseVideo();
                        },
                        child: const Icon(
                          Icons.pause,
                          color: Colors.black,
                          size: 32,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isCurrentMusicPlaying = true;
                          });

                          _controller.playVideo();
                        },
                        child: const Icon(
                          Icons.play_circle_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 30,
            width: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: TextFormField(
              style: const TextStyle(
                  color: Colors.grey, fontFamily: 'QRegular', fontSize: 12),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                fillColor: Colors.grey[200],
                hintText: 'Enter a YouTube URL',
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  String extractVideoIdFromUrl(String url) {
    final regExp = RegExp(
      r'^.*(?:youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=|\?v=)([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    return '';
  }
}
