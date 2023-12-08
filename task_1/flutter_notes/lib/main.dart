import 'package:flutter/material.dart';
import 'package:flutter_notes/features/app/app.dart';
import 'package:surf_logger/surf_logger.dart';

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

void main() {
  _initLogger();
  runApp(const NotesApp());
}
