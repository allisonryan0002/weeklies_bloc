import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weeklies/blocs/tasks/tasks.dart';
import 'package:weeklies/models/models.dart';
import 'package:weeklies/models/sort.dart';
import 'package:weeklies/widgets/widgets.dart';

// class MockCallback extends Mock implements Function {
//   call(Priority p) {}
// }

class MockTasksBloc extends Mock implements TasksBloc {}

// class MockBlocProvider extends Mock implements BlocProvider {}

class FakeTasksEvent extends Fake implements TasksEvent {}

class FakeTasksState extends Fake implements TasksState {}

//TODO: should the actual Mock be used instead?
class MockCallback {
  int _callCounter = 0;
  void call(Priority p) {
    _callCounter += 1;
  }

  bool called(int expected) => _callCounter == expected;
  void reset() {
    _callCounter = 0;
  }
}

void main() {
  // setUpAll(() {
  //   registerFallbackValue<TasksEvent>(FakeTasksEvent());
  //   registerFallbackValue<TasksState>(FakeTasksState());
  // });
  group('CustomPriorityRadio', () {
    group('PriorityRadioIcon', () {
      testWidgets(
        "renders correctly",
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: PriorityRadioIcon(
                    Priority.low.radio(ColorThemeOption.theme1.colorTheme)),
              ),
            ),
          );
          expect(find.byType(PriorityRadioIcon), findsOneWidget);
          expect(find.text('5'), findsOneWidget);
        },
      );
    });

    group('CustomPriorityRadioWidget', () {
      late TasksBloc tasksBloc;

      setUpAll(() {
        registerFallbackValue<TasksEvent>(FakeTasksEvent());
        registerFallbackValue<TasksState>(FakeTasksState());
      });

      setUp(() {
        tasksBloc = MockTasksBloc();
      });

      testWidgets("renders correctly", (WidgetTester tester) async {
        final mockedCallback = MockCallback();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPriorityRadio(mockedCallback, Priority.med),
            ),
          ),
        );
        expect(find.byType(CustomPriorityRadio), findsOneWidget);
        expect(find.byType(PriorityRadioIcon), findsNWidgets(5));
      });

      testWidgets("callback function is called on tap",
          (WidgetTester tester) async {
        final mockedCallback = MockCallback();

        // when(() => tasksBloc.state).thenAnswer((_) =>
        //     TasksLoadSuccess([], SortType.priority, ColorThemeOption.theme1));
        // when(() => (tasksBloc.state as TasksLoadSuccess).theme.colorTheme)
        //     .thenAnswer((_) => ColorThemeOption.theme1.colorTheme);
        await tester.pumpWidget(
          BlocProvider.value(
            value: tasksBloc,
            child: Builder(
              builder: (BuildContext context) {
                when(() => tasksBloc.state).thenAnswer((_) => TasksLoadSuccess(
                    [], SortType.priority, ColorThemeOption.theme1));
                // when(() => context.select<TasksBloc, TasksState>((bloc) =>
                //     bloc.state is TasksLoadSuccess
                //         ? TasksLoadSuccess()
                //         : TasksLoadInProgress())).thenAnswer((_) =>
                //     TasksLoadSuccess(
                //         [], SortType.priority, ColorThemeOption.theme1));
                return MaterialApp(
                  home: Scaffold(
                    body: CustomPriorityRadio(mockedCallback, Priority.med),
                  ),
                );
              },
            ),
          ),
        );
        final radioIconFinder = find.widgetWithText(PriorityRadioIcon, '2');
        await tester.tap(radioIconFinder);
        //verify(() => mockedCallback.call(Priority.high)).called(1);
        expect(mockedCallback.called(1), true);
      });
    });
  });
}
