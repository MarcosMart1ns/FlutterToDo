import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  Widget build(BuildContext context) {
    final TextEditingController inputController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    List<String> _tasks = List();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal,
      systemNavigationBarColor: Colors.teal,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use ita to set our appbar title.
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
                child: Row(children: [
              Expanded(
                child: TextFormField(
                  key: _formKey,
                  validator: (value) {
                    print(value);
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
                    if (inputController.text != '') {
                      setState(() {
                        _tasks.add(inputController.text);
                      });
                      inputController.clear();
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.teal,
                ),
              ),
            ])),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(_tasks[index]),
                  ));
                },
                itemCount: _tasks.length,
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
