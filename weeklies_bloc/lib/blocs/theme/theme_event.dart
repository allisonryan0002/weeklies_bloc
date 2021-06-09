import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final ColorThemeOption theme;

  const ThemeChanged(this.theme);

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeChanged { Theme: $theme }';
}
