import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:fts/pages/home.dart';
import 'package:fts/pages/leaderboard.dart';
import 'package:fts/pages/profile.dart';
import 'package:fts/pages/sas_feed.dart';
import 'package:fts/pages/voice.dart';

import 'package:http/http.dart';
import 'dart:io';
import 'dart:async';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  AnotherAudioRecorder? _recorder;

  static const List<Widget> _pages = <Widget>[
    Home(),
    SASFeed(),
    Leaderboard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _init();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        _startRecording();
        Future.delayed(const Duration(seconds: 10), () {
          _stopRecording();
        });
      },
    );

    super.initState();
  }

  void _init() async {
    try {
      bool hasPermission = await AnotherAudioRecorder.hasPermissions;
      if (hasPermission == true) {
        // AnotherAudioRecorder('file.mp4');
        // await _recorder?.initialized;
        Directory appDocDirectory;
        appDocDirectory = (await getExternalStorageDirectory())!;

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        var customPath = appDocDirectory.path +
            "/recording_" +
            DateTime.now().millisecondsSinceEpoch.toString();

        _recorder =
            AnotherAudioRecorder(customPath, audioFormat: AudioFormat.WAV);
        await _recorder?.initialized;
        print("Recorder initialized");
      }
    } catch (e) {
      print(e);
    }
  }

  void _startRecording() async {
    await _recorder?.start();
    print("Started recording");
  }

  void _stopRecording() async {
    var res = await _recorder?.stop();
    print("Stopped recording, ${res?.path}");
    _sendFile(res?.path, Uri.http("192.168.21.214:8080", ""));
  }

  void _sendFile(filePath, url) async {
    var request = MultipartRequest("POST", url);
    request.files.add(await MultipartFile.fromPath('audio', filePath));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("SAS Fat to Slim"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()))
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/avatar.jpg"),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'SAS Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
            ),
          ],
          currentIndex: _pageIndex,
          onTap: _onItemTapped,
        ),
        body: _pages[_pageIndex]
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
