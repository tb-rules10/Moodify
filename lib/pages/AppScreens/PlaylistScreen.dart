import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/buttons.dart';
import '../../components/floatingActionButton.dart';
import '../../components/inputFields.dart';
import '../../components/videoPlayer.dart';
import '../../constants/textStyles.dart';
import '../../utils/API-Model.dart';


class PlaylistScreen extends StatefulWidget {
  static String id = "PlaylistScreen";
  bool play = false;

  PlaylistScreen({
    required this.title,
    required this.songs,
  });
  final String title;
  final List<Songs> songs;
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<Null>.delayed(Duration.zero, () {
      if(widget.songs.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Internal Error, Server might be down"))
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: height*0.165,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(20, height * 0.04, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const GoBackButton(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 15),
              ),
              Text(
                widget.title,
                textAlign: TextAlign.left,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.songs.length,
            itemBuilder: (context, index) {
              return ListTile(
                  focusNode: focusNode,
                leading: Image.network(widget.songs[index].thumbnailUrl,),
                subtitle: (widget.songs[index].channelTitle == "  ") ? null :
                Text(
                  widget.songs[index].channelTitle,
                  style: kMusicInfoStyle,
                ),
                title: Text(
                  widget.songs[index].title,
                  style: kMusicTitleStyle,
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Theme.of(context).colorScheme.tertiary,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.play_arrow, color: Colors.white,),
                                  title: Text(
                                    'Play',
                                    style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          fontSize: 18
                                        )
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.play = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.close,  color: Colors.white,),
                                  title: Text('Remove'),
                                  onTap: () {
                                    setState(() {
                                      widget.songs.remove(widget.songs[index]);
                                      widget.play = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                    (widget.play) ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                          videoId: widget.songs[index].id,
                          thumbnailUrl: widget.songs[index].thumbnailUrl,
                          title: widget.songs[index].title,
                          channelTitle: widget.songs[index].channelTitle,
                        ),
                      ),
                    ) : null;
                  },
                  child: Icon(Icons.more_vert, color: Colors.grey,),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        videoId: widget.songs[index].id,
                        thumbnailUrl: widget.songs[index].thumbnailUrl,
                        title: widget.songs[index].title,
                        channelTitle: widget.songs[index].channelTitle,
                      ),
                    ),
                  )
                },
              );
            },
          ),
        ),
      ),

    );
  }
}

