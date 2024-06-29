
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/models/model.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoadSuccess extends ToDoState {
  final List<ToDo> todos;

  const ToDoLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];
}

class ToDoOperationFailure extends ToDoState {}
