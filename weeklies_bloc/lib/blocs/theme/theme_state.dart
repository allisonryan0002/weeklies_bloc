import 'package:equatable/equatable.dart';
import 'package:weeklies/models/models.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeLoadInProgress extends ThemeState {}

class ThemeLoadSuccess extends ThemeState {
  final ColorThemeOption theme;

  const ThemeLoadSuccess({required this.theme});

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeLoadSuccess { theme: $theme }';
}
