import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Expose the data. What is the data that we are going to provide.
    final String data = "Some data";
    //Put the provider as high up as it needs to be. We put it at the very top
    //since we need the data the appbar and level3.
    //Create a provider widget with specifying the data type that we are providing.
    //Here the data type is String
    return Provider<String>(
      //Need to create  a property called create that takes the current build context
      // so it knows where it is within the widget tree. And then it has to return
      //the data that needs to be available to all the children. In our case it's the
      //data string. Now i got my data being provided at the very top of the tree and
      // then I can ask the provider to give me that data wherever I need it.
      create: (context) => data,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(data),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Here the data string is being passed all the way down to the level 3 stateless
    // widget.
    return Text(Provider.of<String>(context));
  }
}
