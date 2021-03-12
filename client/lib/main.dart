import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Movie search';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var _title = 'hei';

  Future<http.Response> fetchMovie(q_str) {
    var params = {
      "q": q_str,
    };
    return http.get(Uri.http('localhost:3000', '/movie/rec', params));
  }

  void _setTitle(q) {
    fetchMovie(q).then((response) {
      setState(() {
        _title = response.body;
      });
    }, onError: (error) {
      setState(() {
        _title = "An error";
      });
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              _title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'They are going to the moon, when shit hits the fan',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _setTitle(myController.text);
                print(myController.text);
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   var movieTitle = 'Search for a movie';

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(movieTitle),
//             MyCustomForm(),
//             // TextField(
//             //   decoration: InputDecoration(
//             //       border: InputBorder.none, hintText: 'Enter a search term'),
//             // ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// // Create a Form widget.
// class MyCustomForm extends StatefulWidget {
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// // Create a corresponding State class.
// // This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a GlobalKey<FormState>,
//   // not a GlobalKey<MyCustomFormState>.
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             validator: (value) {
//               if (value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Validate returns true if the form is valid, or false
//                 // otherwise.
//                 if (_formKey.currentState.validate()) {
//                   // If the form is valid, display a Snackbar.
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text('Processing Data')));
//                 }
//               },
//               child: Text('Submit'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // // Define a custom Form widget.
// // class MyCustomForm extends StatefulWidget {
// //   @override
// //   _MyCustomFormState createState() => _MyCustomFormState();
// // }

// // // Define a corresponding State class.
// // // This class holds data related to the Form.
// // class _MyCustomFormState extends State<MyCustomForm> {
// //   // Create a text controller and use it to retrieve the current value
// //   // of the TextField.
// //   final myController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();

// //     myController.addListener(_printLatestValue);
// //   }

// //   @override
// //   void dispose() {
// //     // Clean up the controller when the widget is removed from the widget tree.
// //     // This also removes the _printLatestValue listener.
// //     myController.dispose();
// //     super.dispose();
// //   }

// //   _printLatestValue() {
// //     print("last: ${myController.text}");
// //   }

// //   _submittMovie() {
// //     print("Query: ${myController.text}");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       controller: myController,
// //       onSubmitted: _submittMovie(),
// //     );
// //   }
// // }
