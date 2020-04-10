import 'dart:io';

Future<bool> createFile(String path) async {
  final tempDic = new Directory(path);
  var exits = await tempDic.exists();
  if (exits) {
    return Future(() => false);
  }
  tempDic.createSync(recursive: true);
  return Future(() => true);
}

// 该文件调用的时候. 必须存在父级文件夹
Future<void> writeContent2Path(String path,String fileName, String content) async {
  var file = File('$path/$fileName');
  var sink = file.openWrite();
  sink.write(content);
  await sink.flush();
  await sink.close();
  return Future.value();
}