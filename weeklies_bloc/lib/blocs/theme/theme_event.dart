import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged(this.theme);

  final ColorThemeOption theme;

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeChanged { Theme: $theme }';
}
