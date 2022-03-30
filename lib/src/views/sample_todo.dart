import 'package:flutter/material.dart';
import 'package:foodsora/src/models/todo.dart';
import 'package:foodsora/src/view_models/todo_list_view_model.dart';
import 'package:provider/provider.dart';

class SampleTodo extends StatefulWidget {
  const SampleTodo({Key? key}) : super(key: key);

  static const routeName = '/sample_todo';

  @override
  State<SampleTodo> createState() => _SampleTodoState();
}

class _SampleTodoState extends State<SampleTodo> {
  final _txtController = TextEditingController();

  @override
  void initState() {
    _txtController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _txtController.clear();
    _txtController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoListOnProvider = Provider.of<TodoListViewModel>(context);
    final _scrollController = ScrollController();

    print(todoListOnProvider.items);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo List"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
                // thickness: 10,
                // isAlwaysShown: true,
                radius: const Radius.circular(10),
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: todoListOnProvider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TodoItem(item: todoListOnProvider.items[index]);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _txtController,
                onFieldSubmitted: (String value) {
                  todoListOnProvider.add(Todo(value));
                  _txtController.clear();
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter todo',
                  suffixIcon: IconButton(
                    onPressed: () {
                      todoListOnProvider.add(Todo(_txtController.text));
                      FocusManager.instance.primaryFocus?.unfocus();
                      _txtController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.item}) : super(key: key);

  final Todo item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.todo),
    );
  }
}
