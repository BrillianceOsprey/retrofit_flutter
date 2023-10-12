import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_flutter/network_called.dart';
import 'package:retrofit_flutter/task_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client = RestClient(dio);

  List<Task> taskList = [];
  Future<List<Task>> fetchData() async {
    final dio = Dio(); // Provide a dio instance
    dio.options.headers['Demo-Header'] =
        'demo header'; // config your dio headers globally
    final client = RestClient(dio);

    final data = await client.getTasks();
    setState(() {
      taskList = data;
    });

    return data;
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    fetchData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return TaskDetailPage(
                      task: taskList[index],
                    );
                  }),
                );
              },
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(taskList[index].name ?? ''),
                subtitle: Text(taskList[index].createdAt ?? ''),
                trailing: IconButton(
                  onPressed: () async {
                    await client
                        .deleteTask(taskList[index].id ?? '')
                        .then((value) {
                      setState(() {
                        fetchData();
                      });
                    });
                  },
                  icon: const Icon(Icons.delete_forever),
                ),
              ),
            );
          }),
    );
  }
}
