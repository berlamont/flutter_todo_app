import 'package:flutter/material.dart';
import 'package:flutter_todo_app/TodoItem.dart';

void main() {
  runApp(AnotherTodoApp());
}

class AnotherTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TodoItemPage();
  }
}

class CreateTodoItem extends StatefulWidget {
  final onCreateTodoItem;

  CreateTodoItem({@required this.onCreateTodoItem});

  @override
  State<StatefulWidget> createState() {
    return CreateTodoItemState();
  }
}

class CreateTodoItemState extends State<CreateTodoItem> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create new todo item')),
      body: Center(
          child: TextField(
              controller: textEditingController,
              autofocus: true,
              decoration:
                  InputDecoration(labelText: 'Enter todo item name here'))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          widget.onCreateTodoItem(textEditingController.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class TodoItemList extends StatelessWidget {
  final List<TodoItem> todoItems;
  final onTodoItemToggled;

  TodoItemList({@required this.todoItems, @required this.onTodoItemToggled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo Items'),
        ),
        body: ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (context, index) {
              return Card(
                child: CheckboxListTile(
                    title: Text(todoItems[index].getItemName()),
                    tristate: true,
                    value: todoItems[index].getIsComplete(),
                    onChanged: (_) => {onTodoItemToggled(todoItems[index])}),
              );
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/createNewItem'),
            child: Icon(Icons.add)));
  }
}

class TodoItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoItemState();
  }
}

class TodoItemState extends State<TodoItemPage> {
  final List<TodoItem> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Items',
      initialRoute: '/',
      routes: {
        '/': (context) => TodoItemList(
            todoItems: todoItems, onTodoItemToggled: onTodoItemCompleted),
        '/createNewItem': (context) =>
            CreateTodoItem(onCreateTodoItem: onTodoItemCreated)
      },
    );
  }

  void onTodoItemCompleted(TodoItem todoItem) {
    setState(() {
      todoItem.setIsComplete(!todoItem.getIsComplete());
    });
  }

  void onTodoItemCreated(String itemName) {
    setState(() {
      todoItems.add(TodoItem(itemName));
    });
  }
}
