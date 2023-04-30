import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> getDescarga(url) async {
  final downloadsDir = await getExternalStorageDirectory();
  final taskId = await FlutterDownloader.enqueue(
    url: url,
    headers: {}, // optional: header send with url (auth token etc)
    savedDir: downloadsDir!.path,
    showNotification:
        true, // show download progress in status bar (for Android)
    openFileFromNotification:
        true, // click on notification to open downloaded file (for Android)
  );
}
