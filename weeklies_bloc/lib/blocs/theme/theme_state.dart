import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  final ColorThemeOption theme;

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeState { theme: $theme }';
}
