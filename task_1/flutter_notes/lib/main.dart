import 'package:flutter/material.dart';
import 'package:flutter_notes/api/note/hive_note.dart';
import 'package:flutter_notes/domain/note/note.dart';
import 'package:flutter_notes/features/app/app.dart';
import 'package:flutter_notes/util/app_dictionary.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:surf_logger/surf_logger.dart';

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initLogger();
  await Hive.initFlutter();
  //await Hive.deleteBoxFromDisk(AppDictionary.hiveNotesBox);
  Hive.registerAdapter<Note>(NoteAdapter());
  //..registerAdapter<NoteList>(NoteListAdapter());
  //await Hive.openBox<NoteList>(AppDictionary.hiveNotesBox);
  await Hive.openBox<List<Note>?>(AppDictionary.hiveNotesBox);
  runApp(const NotesApp());
}
