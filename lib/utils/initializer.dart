import 'package:expense/data/init_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

mixin Initializer {
  static Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    await Hive.initFlutter(appDocumentDirectory.path);
    DataGetter.initAdaptors();
    await DataGetter.init();
  }
}
