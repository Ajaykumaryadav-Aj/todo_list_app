import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/bloc/todo_event.dart';
import 'package:todo_list_app/bloc/todo_state.dart';
import 'package:todo_list_app/models/model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<RemoveTask>(_onRemoveTask);
    on<UpdateTask>(_onUpdateTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? tasksJson = prefs.getStringList('tasks');
    if (tasksJson != null) {
      final tasks =
          tasksJson.map((json) => Task.fromMap(jsonDecode(json))).toList();
      emit(TaskState(tasks: tasks));
    } else {
      emit(const TaskState());
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    await _saveTasks(updatedTasks);
    emit(TaskState(tasks: updatedTasks));
  }

  Future<void> _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..remove(event.task);
    await _saveTasks(updatedTasks);
    emit(TaskState(tasks: updatedTasks));
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final updatedTasks = state.tasks.map((task) {
      return task.title == event.oldTask.title ? event.task : task;
    }).toList();
    await _saveTasks(updatedTasks);
    emit(TaskState(tasks: updatedTasks));
  }

  Future<void> _saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksJson =
        tasks.map((task) => json.encode(task.toMap())).toList();
    await prefs.setStringList('tasks', tasksJson);
  }
}
