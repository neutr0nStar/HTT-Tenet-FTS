import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'dart:io';
import 'dart:async';

import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class Voice extends StatefulWidget {
  const Voice({Key? key}) : super(key: key);

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  AnotherAudioRecorder? _recorder = null;

  @override
  void initState() {
    // TODO: implement initState
    // _init();
    _init();
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
    _sendFile(res?.path, Uri.http("192.168.136.214:8080", ""));
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
    return Center(
        child: Column(children: [
      ElevatedButton(
          onPressed: () async {
            _startRecording();
          },
          child: Text("Start")),
      ElevatedButton(
          onPressed: () async {
            _stopRecording();
          },
          child: Text("Stop")),
    ]));
  }
}
