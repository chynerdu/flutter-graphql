import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jotam/screens/add.dart';
import 'package:jotam/services/queries.dart';

class Todos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TodosState();
  }
}

class TodosState extends State<Todos> {
    Widget build(BuildContext context) {
      return  Scaffold(
          appBar: AppBar(title: Text('List Todos')),
          body: Container(
            child: Query(
              options: QueryOptions(
                documentNode: gql(getTodos), // this is the query string you just created
                // variables: {
                //   'nRepositories': 50,
                // },
                pollInterval: 10,
              ),
              // Just like in apollo refetch() could be used to manually trigger a refetch
              // while fetchMore() can be used for pagination purpose
              builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
                if (result.hasException) {
                    return Text(result.exception.toString());
                }

                if (result.loading) {
                  return Text('Loading');
                }

                // it can be either Map or List
                List repositories = result.data['todos'];

                return ListView.builder(
                  itemCount: repositories.length,
                  itemBuilder: (context, index) {
                    final repository = repositories[index];
                    return ListTile(title: Text(repository['title']));

                });
              },
            )
            //  child: ListView.builder(
            //    itemCount: 5,
            //    itemBuilder: (context, index) {
            //       return ListTile(
            //        title: Text('Item One')
            //      );
            //    },
            //  )
          ,),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodo())
              );
            }
          ,),
        );
      
    }
}
