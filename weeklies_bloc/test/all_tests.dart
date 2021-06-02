import './clients/file_client_test.dart' as file_client;

import './repositories/task_repository_test.dart' as task_repository;

import './blocs/tasks_bloc_test.dart' as tasks_bloc;
import './blocs/tasks_event_test.dart' as tasks_event;
import './blocs/tasks_state_test.dart' as tasks_state;

import './models/day_test.dart' as day;
import './models/day_radio_test.dart' as day_radio;
import './models/priority_test.dart' as priority;
import './models/priority_radio_test.dart' as priority_radio;
import './models/sort_test.dart' as sort;
import './models/task_test.dart' as task;

import './widgets/day_sort_button_test.dart' as day_sort_button;
import './widgets/priority_sort_button_test.dart' as priority_sort_button;
import './widgets/custom_priority_radio_test.dart' as custom_priority_radio;

void main() {
  // Clients
  file_client.main();

  // Repositories
  task_repository.main();

  // Blocs
  tasks_bloc.main();
  tasks_event.main();
  tasks_state.main();

  // Models
  day.main();
  day_radio.main();
  priority.main();
  priority_radio.main();
  sort.main();
  task.main();

  // Widgets
  day_sort_button.main();
  priority_sort_button.main();
  custom_priority_radio.main();
}
