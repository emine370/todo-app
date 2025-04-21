import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ToDoApp(), theme: ThemeData.dark()));

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final _controller = TextEditingController();
  final _tasks = <Map<String, dynamic>>[];

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add({'name': text, 'done': false});
        _controller.clear();
      });
    }
  }

  void _toggleTask(int i) {
    setState(() {
      _tasks[i]['done'] = !_tasks[i]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            onSubmitted: (_) => _addTask(),
            decoration: InputDecoration(hintText: 'Yeni görev'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, i) => ListTile(
                leading: Checkbox(
                  value: _tasks[i]['done'],
                  onChanged: (_) => _toggleTask(i),
                ),
                title: Text(
                  _tasks[i]['name'],
                  style: TextStyle(
                    decoration: _tasks[i]['done']
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
