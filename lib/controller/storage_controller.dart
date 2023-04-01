import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageController {
  final storage = FlutterSecureStorage();
  Future<String?> checkForAuth() async {
    String? value = await storage.read(key: "token");
    return value;
  }
  addForAuth(String token) async {
    await storage.write(key: "token", value: token);
  }
  deleteAuth() async {
    await storage.delete(key: "token");
  }
}