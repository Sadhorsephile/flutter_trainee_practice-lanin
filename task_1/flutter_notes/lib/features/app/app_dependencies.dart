import 'package:flutter/material.dart';
import 'package:flutter_notes/features/app/app.dart';
import 'package:flutter_notes/util/default_error_handler.dart';
import 'package:provider/provider.dart';

/// Widget with dependencies that live all runtime.
class AppDependencies extends StatefulWidget {
  ///App instanse.
  final NotesApp app;

  /// @nodoc
  const AppDependencies({required this.app, super.key});

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final DefaultErrorHandler _defaultErrorHandler;

  @override
  void initState() {
    super.initState();
    _defaultErrorHandler = DefaultErrorHandler();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DefaultErrorHandler>(
          create: (_) => _defaultErrorHandler,
        ),
      ],
      child: widget.app,
    );
  }
}
