
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/models/model.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class AddToDo extends ToDoEvent {
  final ToDo todo;

  const AddToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateToDo extends ToDoEvent {
  final ToDo todo;

  const UpdateToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteToDo extends ToDoEvent {
  final String id;

  const DeleteToDo(this.id);

  @override
  List<Object> get props => [id];
}
