import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_flutter/main.dart';
import 'package:retrofit_flutter/network_called.dart';

final dio = Dio();

class TaskDetailPage extends StatefulWidget {
  final Task task;
  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final client = RestClient(dio);

  final nameController = TextEditingController();
  void loadData() {
    nameController.text = widget.task.name ?? '';
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(Icons.person),
            ),
            TextFormField(
              controller: nameController,
              onChanged: (value) {
                nameController.text = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.task.createdAt ?? ''),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await client
              .updateTask(
                  widget.task.id ?? '',
                  Task(
                      name: nameController.text,
                      avatar: widget.task.avatar,
                      createdAt: widget.task.createdAt))
              .then((value) {
            logger.t(value);
          }).catchError((onError) {
            switch (onError.runtimeType) {
              case DioException:
                final res = (onError as DioException).response;
                logger.e(
                    'Got error : ${res?.statusCode ?? ''} --> ${res?.statusMessage ?? ''}');
                break;
              default:
                break;
            }
          });
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
