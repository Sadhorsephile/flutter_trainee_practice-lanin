import 'package:flutter/material.dart';
import 'package:flutter_notes/api/note/data_provider.dart';
import 'package:flutter_notes/features/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surf_logger/surf_logger.dart';

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLogger();
  await Hive.initFlutter();
  await NoteDataProvider.init();
  runApp(const NotesApp());
}
