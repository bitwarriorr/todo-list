import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const ToDoListPage(title: 'ToDo List App'),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController _textController = TextEditingController();
  List<String> toDoList = [];

  void _addToDo() {
    String newToDo = _textController.text.trim();
    if (newToDo.isNotEmpty) {
      setState(() {
        toDoList.add(newToDo);
      });
      _textController.clear();
    }
  }

  void _removeToDoAtIndex(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Add a ToDo',
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  onSubmitted: (value) => _addToDo(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _addToDo(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: toDoList[index].startsWith('✔')
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  leading: Checkbox(
                    value: toDoList[index].startsWith('✔'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          toDoList[index] = (value ? '✔ ' : '') +
                              toDoList[index].replaceAll('✔ ', '');
                        }
                      });
                    },
                  ),
                  title: Text(toDoList[index].replaceAll('✔ ', '')),
                  trailing: InkWell(
                    onTap: () => _removeToDoAtIndex(index),
                    child: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
