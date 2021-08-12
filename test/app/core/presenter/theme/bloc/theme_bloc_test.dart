import 'package:a_tiku/app/core/presenter/theme/app_themes.dart';
import 'package:a_tiku/app/core/presenter/theme/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ThemeBloc bloc;

  setUp(() {
    bloc = ThemeBloc();
  });

  blocTest<ThemeBloc, ThemeState>(
    'emits [ThemeState] when ThemeChanged is dispatched.',
    build: () => bloc,
    act: (bloc) => bloc.add(ThemeChanged(theme: AppTheme.Light)),
    expect: () => <ThemeState>[
      ThemeState(themeData: appThemeData[AppTheme.Light]!),
    ],
  );
}
