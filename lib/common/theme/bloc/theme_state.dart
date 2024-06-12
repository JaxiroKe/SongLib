part of 'theme_bloc.dart';

enum ThemeStatus { initial, loading, refreshing, success, failure }

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatus.initial,
    this.themeType = ThemeType.system,
    this.useDarkTheme = false,
    this.useMaterialYouTheme = false,
    this.reduceAnimations = false,
  });

  final ThemeStatus status;

  // Theming options
  final ThemeType themeType;
  final bool useDarkTheme;
  final bool useMaterialYouTheme;
  final bool reduceAnimations;

  ThemeState copyWith({
    required ThemeStatus status,
    ThemeType? themeType,
    bool? useDarkTheme,
    bool? useMaterialYouTheme,
    bool? reduceAnimations,
  }) {
    return ThemeState(
      status: status,
      themeType: themeType ?? ThemeType.system,
      useDarkTheme: useDarkTheme ?? false,
      useMaterialYouTheme: useMaterialYouTheme ?? false,
      reduceAnimations: reduceAnimations ?? false,
    );
  }

  @override
  List<Object?> get props => [status, themeType, useDarkTheme, useMaterialYouTheme, reduceAnimations];
}
