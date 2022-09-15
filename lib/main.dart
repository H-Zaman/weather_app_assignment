import 'package:flutter/material.dart';
import 'package:weather/app.dart';
import 'package:weather/src/utilities/local_storage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();

  runApp(const MyApp());
}
