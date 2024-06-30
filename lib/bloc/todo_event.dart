

import 'package:todo_list_app/models/model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class RemoveTask extends TaskEvent {
  final Task task;
  RemoveTask(this.task);
}

// class UpdateTask extends TaskEvent {
//   final Task task;
//   UpdateTask(this.task);
// }

class UpdateTask extends TaskEvent {
  final Task oldTask;
  final Task task;

  UpdateTask(this.oldTask, this.task);
}

