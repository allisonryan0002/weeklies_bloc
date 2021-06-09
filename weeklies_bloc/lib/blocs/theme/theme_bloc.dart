import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final TaskRepository tasksRepository;
  final ColorThemeOption initialTheme;

  ThemeBloc({required this.tasksRepository, required this.initialTheme})
      : super(ThemeState(theme: initialTheme));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield* _mapThemeChangedToState(event);
    }
  }

  Stream<ThemeState> _mapThemeChangedToState(ThemeChanged event) async* {
    if (state is ThemeState) {
      yield ThemeState(theme: event.theme);
    }
    _saveTheme(event.theme);
  }

  void _saveTheme(ColorThemeOption theme) {
    tasksRepository.saveTheme(theme);
  }
}
