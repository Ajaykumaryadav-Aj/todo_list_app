
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/models/model.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const ToDoLoadSuccess([])) {
    on<AddToDo>(_onAddToDo);
    on<UpdateToDo>(_onUpdateToDo);
    on<DeleteToDo>(_onDeleteToDo);
  }

  void _onAddToDo(AddToDo event, Emitter<ToDoState> emit) {
    if (state is ToDoLoadSuccess) {
      final updatedToDos = List<ToDo>.from((state as ToDoLoadSuccess).todos)
        ..add(event.todo);
      emit(ToDoLoadSuccess(updatedToDos));
    }
  }

  void _onUpdateToDo(UpdateToDo event, Emitter<ToDoState> emit) {
    if (state is ToDoLoadSuccess) {
      final updatedToDos = (state as ToDoLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(ToDoLoadSuccess(updatedToDos));
    }
  }

  void _onDeleteToDo(DeleteToDo event, Emitter<ToDoState> emit) {
    if (state is ToDoLoadSuccess) {
      final updatedToDos = (state as ToDoLoadSuccess).todos
          .where((todo) => todo.id != event.id)
          .toList();
      emit(ToDoLoadSuccess(updatedToDos));
    }
  }

  
}
