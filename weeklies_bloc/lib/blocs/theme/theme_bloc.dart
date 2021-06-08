import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final TaskRepository tasksRepository;

  ThemeBloc({required this.tasksRepository}) : super(ThemeLoadInProgress());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoaded) {
      yield* _mapThemeLoadedToState();
    } else if (event is ThemeChanged) {
      yield* _mapThemeChangedToState(event);
    }
  }

  Stream<ThemeState> _mapThemeLoadedToState() async* {
    final theme = await this.tasksRepository.loadTheme();
    yield ThemeLoadSuccess(theme: theme);
  }

  Stream<ThemeState> _mapThemeChangedToState(ThemeChanged event) async* {
    if (state is ThemeLoadSuccess) {
      yield ThemeLoadSuccess(theme: event.theme);
    }
    _saveTheme(event.theme);
  }

  void _saveTheme(ColorThemeOption theme) {
    tasksRepository.saveTheme(theme);
  }
}
