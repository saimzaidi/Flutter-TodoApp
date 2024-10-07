import 'package:flutter/material.dart';
import 'package:todo/utils/color.dart';
import 'package:todo/widgets/appbar.dart';
import 'package:todo/widgets/searchbar.dart';
import 'package:todo/widgets/todosnippet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> todoList = []; // Example data for testing
  List<Map> foundTodo = [];
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foundTodo = todoList; // Initially, display all todos
  }

  // Function to run the filter based on entered keyword
  void runFilter(String keyword) {
    List<Map> results = [];
    
    // If the search field is empty, display all todos
    if (keyword.isEmpty) {
      results = todoList;
    } else {
      // Filter the todoList and return only todos that match the search keyword
      results = todoList
          .where((todo) => todo['text']
              .toLowerCase()
              .contains(keyword.toLowerCase())) // Case-insensitive search
          .toList();
    }

    setState(() {
      foundTodo = results; // Update the displayed list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      drawer: Drawer(),
      body: Stack(
        children: [
          // Main content of the screen goes here
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchbBarWidget(
                  Filter: (value) {
                    runFilter(value); // Pass the entered value to the runFilter function
                  }
                ),
                SizedBox(height: 50),
                Text(
                  "All ToDos",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 80),
                    child: ListView.builder(
                      itemCount: foundTodo.length, // Use foundTodo instead of todoList
                      itemBuilder: (context, index) {
                        return todoSnippet(
                          isDone: foundTodo[index]["isDone"],
                          text: foundTodo[index]["text"],
                          onToggle: () {
                            setState(() {
                              foundTodo[index]["isDone"] = !foundTodo[index]["isDone"];
                            });
                          },
                          onDelete: () {
                            setState(() {
                              todoList.removeAt(index);
                              runFilter(''); // Update the list after deletion
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Positioned input row at the bottom
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Enter a todo item",
                        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(right: 15),
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: tdBlue,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (textController.text.isNotEmpty) {
                          // Insert a new todo item as a Map with 'text' and 'isDone' fields
                          todoList.insert(0, {
                            "text": textController.text,
                            "isDone": false,
                          });
                          textController.clear(); // Clear the TextField after adding the todo
                          runFilter(''); // Refresh the list to include the new todo
                        }
                      });
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
