import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Use the ChangeNotifierProvider at the top to provide changes in Data class
    // which extends ChangeNotifier
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
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
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listening and getting data from Data class. When the data property updates,
    //then this text widget is going to rebuild itself to reflect that change.
    return Text(Provider.of<Data>(context).data);
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Another important thing to remember is that this provider.of method
    // actually has an optional parameter called listen. Let's say that we want it
    // to get the original value of the data that's stored but we don't want it to
    //listen for updates. We don't want to rebuild every time this data changes. Then
    // all we have to do is to add the listen property and we can change it to false.
    // Now by default this property is set to true which is why every time
    // you use provider.of you're getting a listener which is going to update itself
    // based on changes in that thing that you're listening for. Here, it only shows the
    //original value. It doesn't listen for the updates.
    return Text(Provider.of<Data>(context, listen: false).data);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newText) {
        //Updating the data in Data class
        Provider.of<Data>(context, listen: false).changeString(newText);
      },
    );
  }
}

//Make the Data class extend the ChangeNotifier class. This ChangeNotifier
//actually comes from Flutter itself. This is not something that came with provider.
//It already exists and it exists for the purpose of notifying listeners
//to this particular class of any updates in the class.
class Data extends ChangeNotifier {
  //Expose the data. What is the data that we are going to provide.
  String data = 'Some data';

  void changeString(String newString) {
    data = newString;
    // notifyListeners method is available since we are inheriting from the
    //ChangeNotifier. So what this does is as soon as we update our data to the new
    //value, we call notify listeners so that everybody who's listening to our
    // provider can rebuild their widgets as well because they're notified of
    //that state change.
    notifyListeners();
  }
}
