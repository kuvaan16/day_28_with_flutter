import 'package:day_28_with_flutter/todo_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<ToDoList> todolist = List.empty(growable: true);
  final _todolist = TextEditingController();
  bool done = false;
  int checked = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "To-Do List",
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset(
                  "img/to-do-list.png",
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(156, 224, 224, 224),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    controller: _todolist,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Add your task",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Positioned(
                  right: -14,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      String todo = _todolist.text.trim();
                      if (todo.isNotEmpty) {
                        setState(() {
                          todolist.add(ToDoList(text: todo, cheked: false));
                          _todolist.text = "";
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.amber[900],
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            todolist.isEmpty
                ? Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Nothing to do (:",
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: todolist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    todolist[index].cheked =
                                        !todolist[index].cheked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      todolist[index].cheked
                                          ? Icons.check_circle_sharp
                                          : Icons.circle_outlined,
                                      color: todolist[index].cheked
                                          ? Colors.amber[900]
                                          : Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      todolist[index].text,
                                      style: todolist[index].cheked
                                          ? TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            )
                                          : TextStyle(
                                              fontSize: 18,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    todolist.removeAt(index);
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                              ),
                            ],
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
