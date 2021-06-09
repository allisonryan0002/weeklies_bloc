import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

class ThemeState extends Equatable {
  final ColorThemeOption theme;

  const ThemeState({required this.theme});

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeState { theme: $theme }';
}
