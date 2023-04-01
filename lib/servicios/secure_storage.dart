/* import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageConfig {
  final storage = const FlutterSecureStorage();
}

class SecureStorageKeys extends SecureStorageConfig {
  late String key;/*  */
  late String value;

  SecureStorageKeys(this.key, this.value);

  Future addNewItem() async {
    await storage.write(
      key: key,
      value: value,
    );
    //  print('exito');
    //_readAll();
  }

  Future<String?> readItem() async {
    final read = await storage.read(
      key: key,
    );
    // print(read.toString());
    return read.toString();
    //  return Future.value(read);

    //_readAll();
  }

  add() async {
    var write = await storage.write(key: key, value: value);

    return write;
  }

/*   add() async {
    var write = await storage.write(key: key, value: value);

    return write;
  }

  read() async {
    var read = await storage.read(key: key);

    return read;
  }

  void delete() async {
    await storage.delete(key: key);
  }

  void deleteAll() async {
    await storage.deleteAll();
  } */
}
 */