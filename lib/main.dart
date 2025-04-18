import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoHomePage(),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final TextEditingController _textController = TextEditingController();
  final List<Task> _tasks = [];

  void _addTask() {
    String text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: text));
        _textController.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yapılacaklar Listesi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Görev Ekleme Alanı
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Yeni görev',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Ekle'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Görev Listesi
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text("Henüz görev yok."))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Dismissible(
                          key: Key(task.name + index.toString()),
                          onDismissed: (_) => _deleteTask(index),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: task.isDone,
                              onChanged: (_) => _toggleTask(index),
                            ),
                            title: Text(
                              task.name,
                              style: TextStyle(
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}
