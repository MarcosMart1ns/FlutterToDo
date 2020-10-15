import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// ignore: implementation_imports

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Todo         '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController inputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final DBRef = FirebaseDatabase.instance.reference();

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    // Wait for Firebase to initialize and set `_initialized` state to true
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initializeFlutterFire();
    print('reiniciou');
    super.initState();
  }

  void read() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal,
      systemNavigationBarColor: Colors.teal,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      drawer: Drawer(
          child: Container(
              color: Colors.teal,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('This is the Drawer',
                        style: TextStyle(color: Colors.white)),
                  ]))),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Task Field it\'s required';
                        }
                        return null;
                      },
                      controller: inputController,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontFamily: 'monospace',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Escreva aqui uma nova tarefa',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: RaisedButton(
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            DBRef.child('/mobile')
                                .push()
                                .set({'note': inputController.text});
                          });
                          inputController.clear();
                          read();
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.teal,
                    ),
                  ),
                ])),
            Expanded(
                child: FirebaseAnimatedList(
              query: DBRef.child('/mobile'),
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                    child: ListTile(
                  title: Text(snapshot.value.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      DBRef.child('/mobile').child(snapshot.key).remove();
                    },
                    icon: Icon(Icons.delete),
                  ),
                ));
              },
            )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
