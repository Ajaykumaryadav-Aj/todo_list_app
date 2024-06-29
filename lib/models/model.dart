
import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const ToDo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  ToDo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
