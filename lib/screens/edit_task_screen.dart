import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_list_app/bloc/todo_bloc.dart';
import 'package:todo_list_app/bloc/todo_event.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/models/model.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late Priority _priority;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _description = widget.task.description;
    _priority = widget.task.priority;
    _dueDate = widget.task.dueDate;
  }

  Future<void> showNotification() async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME'
          "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification',
      'Task edit successfully',
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value ?? '',
              ),
              DropdownButtonFormField<Priority>(
                value: _priority,
                items: Priority.values
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority.toString().split('.').last),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _priority = value ?? Priority.low),
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
              TextButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() => _dueDate = selectedDate);
                  }
                },
                child: const Text('Select Due Date'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                  showNotification();
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedTask = widget.task.copyWith(
        title: _title,
        description: _description,
        priority: _priority,
        dueDate: _dueDate,
      );
      context.read<TaskBloc>().add(UpdateTask(widget.task, updatedTask));
      Navigator.of(context).pop();
    }
  }
}
