import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:moodify/components/buttons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants/functions.dart';
import '../constants/textStyles.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String thumbnailUrl;
  final String channelTitle;
  final String title;

  VideoPlayerScreen({
    required this.videoId,
    required this.thumbnailUrl,
    required this.title,
    required this.channelTitle,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool isPlaying = true;
  bool isVideoFinished = false;
  bool showVideo = true;
  int toggleSwitch = 0;
  int videoStart = 0;
  int videoEnd = 0;


  @override
  void initState() {
    super.initState();
    print(widget.videoId);
    print(widget.title);
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideThumbnail: true,
        mute: false,
        hideControls: true,
      ),
    )..addListener(() {
      videoEnd = _controller.metadata.duration.inSeconds;
      setState(() {
        videoStart = _controller.value.position.inSeconds;
      });
      if (videoStart == videoEnd-1 && videoEnd != 0) {
          setState(() {
            isVideoFinished = true;
          });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, height * 0.02, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoBackButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 32,
                        ),
                        ToggleSwitch(
                          minWidth: 80.0,
                          cornerRadius: 20.0,
                          activeBgColor: [Theme.of(context).colorScheme.primary],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.white.withOpacity(0.2),
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: toggleSwitch,
                          totalSwitches: 2,
                          labels: ['Video', 'Song'],
                          radiusStyle: true,
                          onToggle: (index) {
                            setState(() {
                              toggleSwitch = index!;
                              showVideo = !showVideo;
                            });
                          },
                        ),
                        const Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: false,
                          child: GoBackButton(
                            padding: EdgeInsets.all(0),
                            iconSize: 32,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Column(
                children: <Widget>[
                  Visibility(
                    visible: !showVideo,
                    child: Image.network(
                      widget.thumbnailUrl,
                    ),
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: showVideo,
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: false,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                        fontSize:25,
                        fontWeight: FontWeight.w700,
                      )
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.channelTitle,
                    style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                        fontSize:16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      )
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Text("-------------------------------------------------------------------------------"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                    child: Column(
                      children: [
                        ProgressBar(
                          controller: _controller,
                          colors: ProgressBarColors(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            bufferedColor: Colors.white.withOpacity(0.2),
                            playedColor: Theme.of(context).colorScheme.primary,
                            handleColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDuration(videoStart),
                                style: kMusicTimerStyle,
                              ),
                              Text(
                                  formatDuration(videoEnd),
                                style: kMusicTimerStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        shape: CircleBorder(),
                        // color: Theme.of(context).colorScheme.primary,
                        color: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.replay_10,
                          size: 30,
                        ),
                        onPressed: () {
                          _controller.seekTo(Duration(
                              seconds:
                              _controller.value.position.inSeconds - 10));
                        },
                      ),MaterialButton(
                        shape: CircleBorder(),
                        color: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.all(18.0),
                        child: Hero(
                          tag: 'play',
                          child: Icon(
                            (isVideoFinished) ? Icons.replay :
                            (isPlaying) ? Icons.pause : Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if(isVideoFinished) {
                              _controller.seekTo(Duration(seconds: 0));
                              isVideoFinished = false;
                            }
                            else{
                              (isPlaying) ? _controller.pause() : _controller.play();
                              isPlaying = !isPlaying;
                            }
                          });
                        },
                      ),MaterialButton(
                        shape: CircleBorder(),
                        // color: Theme.of(context).colorScheme.primary,
                        color: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.forward_10,
                          size: 30,
                        ),
                        onPressed:  () {
                          _controller.seekTo(Duration(
                              seconds:
                              _controller.value.position.inSeconds + 10));
                        },
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}