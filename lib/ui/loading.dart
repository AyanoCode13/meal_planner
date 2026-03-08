import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_planner/utils/command.dart';

final class LoadingState extends StatelessWidget {
  final List<Command> _commands;
  final List<ChangeNotifier> _notifiers;
  final Widget _child;

  const LoadingState({super.key, required List<Command> commands, required List<ChangeNotifier> notifiers, required Widget child}) : _commands = commands, _notifiers = notifiers, _child = child;

  
  @override
  Widget build(Object context) {
    // TODO: implement build
    return ListenableBuilder(
      listenable: Listenable.merge(_commands),
      builder: (context, child) {
        if (_commands.any((command) => command.running)) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if(_commands.any((command) => command.failed)){
          return Center(child: Text("Error"));
        }
        return child!;
      },
      child: ListenableBuilder(listenable: Listenable.merge(_notifiers), builder: (context, _) {
        return _child;
      }),
    );
  }
}
