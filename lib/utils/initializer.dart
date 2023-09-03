import 'dart:io';

import 'package:expense/data/init_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

mixin Initializer {
  static Future<void> init() async {
    DataGetter.initAdaptors();
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = appDocumentDirectory.path;
    await Hive.initFlutter(path);
    await DataGetter.init();
  }
}
