import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeklies/blocs/theme/theme.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/repositories/repositories.dart';

// Manage the state of the app [ColorThemeOption]
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.themeRepository, required this.initialTheme})
      : super(ThemeState(theme: initialTheme)) {
    on<ThemeChanged>(_onThemeChanged);
  }

  final ThemeRepository themeRepository;
  final ColorThemeOption initialTheme;

  // Change app's current [ColorThemeOption] & save change
  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(ThemeState(theme: event.theme));
    _saveTheme(event.theme);
  }

  void _saveTheme(ColorThemeOption theme) {
    themeRepository.saveTheme(theme);
  }
}
