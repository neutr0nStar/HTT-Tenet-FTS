import 'dart:io';
import 'dart:async';

import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class Recorder {
  AnotherAudioRecorder? _recorder;

  void init() async {
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

  void startRecording() async {
    await _recorder?.start();
    print("Started recording");
  }

  void stopRecordingAndSend(url) async {
    var res = await _recorder?.stop();
    print("Stopped recording, ${res?.path}");
    sendFile(res?.path, Uri.http(url, ""));
  }

  void sendFile(filePath, url) async {
    var request = MultipartRequest("POST", url);
    request.files.add(await MultipartFile.fromPath('audio', filePath));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }
}

// Recorder recorder = Recorder();
