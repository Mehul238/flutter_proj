import 'package:flutter/material.dart';
import 'package:drawer/second.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _Homescreen createState() => _Homescreen();
}

class _Homescreen extends State<HomeScreen> {
  Widget _buildFoodItem(
      String imgPath, String foodName, String price, Function ontap) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade500))),
        child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
            child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      Hero(
                          tag: imgPath,
                          child: Image(
                              image: AssetImage(imgPath),
                              fit: BoxFit.cover,
                              height: 75.0,
                              width: 75.0)),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(foodName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                            Text(price,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Colors.grey))
                          ])
                    ])),
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF1C1428)),
                      child: Center(
                          child: InkWell(
                        splashColor: Colors.red,
                        onTap: ontap,
                        child: Container(
                            height: 50,
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 40,
                            )),
                      )),
                    )
                  ],
                ))));
  }

  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepOrange,
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
                  Colors.yellow[300],
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 1.0, left: 10.0),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(85.0),
                  bottomRight: Radius.circular(85.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0, bottom: 20.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 150.0,
                        child: ListView(children: [
                          _buildFoodItem(
                              'images/genda.jpg',
                              'Genda',
                              'Artist: Badashah',
                              () => audioCache.play('Genda.mp3')),
                          _buildFoodItem(
                              'images/pachtaoge.jpeg',
                              'Pachtaoge',
                              'Artist: Arijit Singh',
                              () => audioCache.play('Pachtaoge.mp3')),
                          _buildFoodItem(
                              'images/shameless.jpg',
                              'Shameless',
                              'Artist: camilla',
                              () => audioCache
                                  .play("Camila Cabello - Shameless.mp3")),
                          _buildFoodItem(
                              'images/best.jpeg',
                              'Best Song Ever',
                              'Artist: One Direction',
                              () => audioCache
                                  .play("Best Song Ever - One Direction.mp3")),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 60.0,
                                        width: 90.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid,
                                                width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Color(0xFF1C1428)),
                                        child: Center(
                                            child: InkWell(
                                          splashColor: Colors.red,
                                          onTap: () => advancedPlayer.stop(),
                                          child: Container(
                                              height: 50,
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "Stop",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ))),
                                        )),
                                      ),
                                      Container(
                                        height: 60.0,
                                        width: 90.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid,
                                                width: 5.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Color(0xFF1C1428)),
                                        child: Center(
                                            child: InkWell(
                                          splashColor: Colors.red,
                                          onTap: () => advancedPlayer.pause(),
                                          child: Container(
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "Pause",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              )),
                                        )),
                                      )
                                    ],
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ))
                        ]))),
              ],
            ),
          )
        ],
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
