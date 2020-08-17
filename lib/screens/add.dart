import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jotam/services/queries.dart';

class AddTodo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTodoState();
  }
}
//  final snackBar = SnackBar(content: Text('Profile succcessfully updated!', style: TextStyle(color: Colors.green)));
// _scaffoldKey.currentState.showSnackBar(snackBar);

class AddTodoState extends State<AddTodo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, dynamic>   _formData =  {
    'todo_title': null
  };

    // void submit() async {
    // if (!emailKey.currentState.validate() 
    //   || !_formKey.currentState.validate() 
    // ) {
    //   print('validation failed');
    //   return;
    // }
    // print('validated');
    // setState(() {
    //   isLoading = true;
    // });    
    // await emailKey.currentState.save();
    // await _formKey.currentState.save();
    // }
    // void save() async {
    //    final value = await _formKey.currentState.save();
    // }

   Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
       appBar: AppBar(title: Text('ADD TODO')),
       body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Text('ADD A TODO', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          Divider(),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
              ),
              validator: (String value) {
                if (value.isEmpty) {
                   return 'Enter title';
                }             
              },
              onSaved: (dynamic value) {
                print('value is $value');
                _formData['todo_title'] = value;
                print('saved value ${_formData['title'] }');
              },
            )
          ),
          SizedBox(height: 20),
          Mutation(
            options: MutationOptions(
              documentNode: gql(addTodos), // this is the mutation string you just created
              // you can update the cache based on results
              update: (Cache cache, QueryResult result) {
                return cache;
              },
              // or do something with the result.data on completion
              onCompleted: (dynamic resultData) {
                print(resultData);
                final snackBar = SnackBar(content: Text('Todo successfull added!', style: TextStyle(color: Colors.green)));
                _scaffoldKey.currentState.showSnackBar(snackBar);
                Navigator.pop(context);
              },
            ),
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return MaterialButton(
                height: 55,
                minWidth: double.infinity,
                color: Colors.black,
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if(!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print('beforw run ${_formData['todo_title']}');
                  runMutation({
                    'title':  _formData['todo_title'],
                  });
                }
              );
            },
          )
          
          
          


        ],)
       )
       

    );
   }

}