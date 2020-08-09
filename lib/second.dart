import 'package:drawer/chewie_list_item.dart';
import 'package:drawer/first.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class mycard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
        child: ChewieListItem(
          videoPlayerController: VideoPlayerController.asset(
            'videos/video.mp4',
          ),
          looping: true,
        ),
      ),
      height: 200,
      width: 330,
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Colors.black,
          blurRadius: 20.0,
        ),
      ]),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  MYAPP createState() => MYAPP();
}

//State is information of the application that can change over time or when some actions are taken.
class MYAPP extends State<VideoPlayerScreen> {
  Widget mycard() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          child: new Card(
            child: Stack(
              children: <Widget>[
                Center(
                    child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
                Center(
                    child: ButtonTheme(
                        height: 50.0,
                        minWidth: 50.0,
                        child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          textColor: Colors.white,
                          onPressed: () {
                            // Wrap the play or pause in a call to `setState`. This ensures the
                            // correct icon is shown.
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 20.0,
                          ),
                        )))
              ],
            ),
          ),
          height: 200,
          width: 330,
          decoration: new BoxDecoration(boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 20.0,
            ),
          ]),
        ));
  }

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://github.com/Mehul238/image/blob/master/video.MP4?raw=true',
    );

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepOrange,
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      appBar: AppBar(
        title: Text("My app"),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.redAccent,
                  Colors.orangeAccent
                ])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 50,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "images/download.png",
                            fit: BoxFit.fill,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Music Library",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                )),
            currentlist(
                Icons.library_music,
                "Audio music",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (HomeScreen())))
                    }),
            currentlist(
                Icons.music_video,
                "Video music",
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (VideoPlayerScreen())))
                    }),
          ],
        ),
      ),

      body: new Container(
        margin: EdgeInsets.only(top: 60),
        height: MediaQuery.of(context).size.height - 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150.0),
              bottomRight: Radius.circular(150.0)),
        ),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: Text(
                      "Online video",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )),
              mycard(),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    child: Text(
                      "Offline video",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )),
              mycard2(),
            ],
          ),
        ),
      ),
    );
  }
}

class currentlist extends StatelessWidget {
  IconData icon;
  String text;
  Function ontap;

  currentlist(this.icon, this.text, this.ontap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade400))),
            child: InkWell(
              splashColor: Colors.red,
              onTap: ontap,
              child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(icon),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                text,
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      ),
                      Icon(Icons.arrow_right)
                    ],
                  )),
            )));
  }
}
