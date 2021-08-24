import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final int no_of_bricks;
  // final String description;

  const Todo(this.no_of_bricks);
}

void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          2,
              (i) => Todo(
            (i*30),

          ),
        ),
      ),
    ),
  );
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("no_of_bricks"),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: todos[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    // Use the Todo to create the UI.
    dynamic? Project(){
      int no_of_bricks= todo.no_of_bricks;
      int i=0;
      int total=0;
      int jackT=0;
      int johnT=0;
      int temp=0;
      int difference=0;
      int y=0;
      String turn="John";
      print("Assignment: Another Brick in the Wall\n");
      print("John & Jack | to construct a wall\n");
      print("input for no_of_bricks: ${no_of_bricks}\n");

      while(total<no_of_bricks)
      {

        i++;
        //John turn
        if(total<no_of_bricks)
        {
          total+=i;
          johnT+=1;
          temp=i;
          turn="John";
          if(total>no_of_bricks)
          {
            difference= total - no_of_bricks;
            y=temp-difference;
            print("John  ${i}    -> ${i} -> ${total-i}+${y}  -> ${no_of_bricks}");}
          else if(total<=no_of_bricks)
          {
            y=i;
            print("John  ${i}    -> ${i} -> ${total-i}+${i}  -> ${total}");
          }
        }

        //Jack turn
        if(total<no_of_bricks)
        {
          total+=(i*2);
          jackT+=1;
          temp=i*2;
          turn="Jack";
          if(total>no_of_bricks)
          {
            difference= total - no_of_bricks;y=temp-difference;
            print("Jack  ${i}* 2 -> ${i*2} -> ${total-i*2}+${y}  -> ${no_of_bricks}");}
          else if(total<=no_of_bricks)
          {
            y=i*2;
            print("Jack  ${i}* 2 -> ${i*2} -> ${total-i*2}+${i*2}  -> ${total}");
          }
        }

      }

      print("\nConclusions\n");
      print("\nTurns of John[${johnT}] and Jack[${jackT}]");
      print("\nWho placed the Last Brick: ${turn}");
      print("\nHow many bricks were placed lastly: ${y}");

    }

    return Scaffold(
        appBar: AppBar(
          title: Text(todo.no_of_bricks.toString()),
        ),
        body: Column(children: [Project()]
        ));



  }
}



