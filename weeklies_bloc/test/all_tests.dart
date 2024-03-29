import 'blocs/tasks/tasks_bloc_test.dart' as tasks_bloc;
import 'blocs/tasks/tasks_event_test.dart' as tasks_event;
import 'blocs/tasks/tasks_state_test.dart' as tasks_state;
import 'blocs/theme/theme_bloc_test.dart' as theme_bloc;
import 'blocs/theme/theme_event_test.dart' as theme_event;
import 'blocs/theme/theme_state_test.dart' as theme_state;
import 'clients/file_client_test.dart' as file_client;
import 'models/day_test.dart' as day;
import 'models/priority_test.dart' as priority;
import 'models/sort_test.dart' as sort;
import 'models/task_test.dart' as task;
import 'repositories/task_repository_test.dart' as task_repository;
import 'utility/adjusted_day_test.dart' as adjusted_day;
import 'widgets/custom_color_theme_radio_test.dart' as custom_color_theme;
import 'widgets/custom_day_radio_test.dart' as custom_day_radio;
import 'widgets/custom_priority_radio_test.dart' as custom_priority_radio;
import 'widgets/day_sort_button_test.dart' as day_sort_button;
import 'widgets/priority_sort_button_test.dart' as priority_sort_button;
import 'widgets/task_input_test.dart' as task_input;
import 'widgets/task_list_view_test.dart' as task_list_view;
import 'widgets/task_tile_text_field_test.dart' as task_tile_text_field;

void main() {
  // Clients
  file_client.main();

  // Repositories
  task_repository.main();

  // Blocs
  tasks_bloc.main();
  tasks_event.main();
  tasks_state.main();
  theme_bloc.main();
  theme_event.main();
  theme_state.main();

  // Models
  day.main();
  priority.main();
  sort.main();
  task.main();

  // Widgets
  day_sort_button.main();
  priority_sort_button.main();
  custom_priority_radio.main();
  custom_day_radio.main();
  custom_color_theme.main();
  task_tile_text_field.main();
  task_input.main();
  task_list_view.main();

  //Other
  adjusted_day.main();
}
