import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:foodsora/src/models/todo.dart';

class TodoListViewModel with ChangeNotifier {
  final List<Todo> _items = [
    const Todo("test"),
    const Todo("test 2"),
    const Todo("test 3"),
  ];

  UnmodifiableListView<Todo> get items => UnmodifiableListView(_items);

  void add(Todo item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
