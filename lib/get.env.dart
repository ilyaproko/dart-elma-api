import 'package:path/path.dart';
import 'dart:io' as io;

/// get data from file .env in main dictionary of the project
/// The data in .env file should be represent by separate symbol equals =
/// The symbol separate key and value. In this case the method return
/// object with these keys and values in .env file
Future<Map<String, String>> getEnv() async {
  // C:\Users\...\...\<your_project>\.env
  var fileEnv =
      await io.File(join(io.Directory.current.path, ".env")).readAsString();

  var lines = fileEnv.split("\n");

  Map<String, String> env = <String, String>{};

  if (lines.isNotEmpty) {
    for (var record in lines) {
      if (record.split("=").length == 2) {
        var rec = record.split("=");
        env.addAll({rec[0]: rec[1].replaceAll("\r", "")});
      }
    }
  }

  return env;
}
