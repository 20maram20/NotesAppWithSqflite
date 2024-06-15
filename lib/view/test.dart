import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/notecubit.dart';
import 'package:notes_app/cubit/notestate.dart';
import 'package:notes_app/sqldb.dart';

import '../widgets/noteitem.dart';
import 'edit.dart';
class test extends StatefulWidget {
  const test({super.key});


  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
   List<Map<String, dynamic>> notes=[];

  @override
  void initState() {
    BlocProvider.of<SqlDb>(context).read("notes");

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body:BlocBuilder<SqlDb,Notestate>(builder: (context, state) {
        if(state is Readnote){
          return Column(
            children: [
              // TextButton(
              //     onPressed: (){
              //       sqlDb.mydeleteDatabase().then((_) {
              //         // After deleting the database, update the UI by triggering a rebuild
              //         sqlDb.read("notes").then((noteList) {
              //           setState(() {
              //             notes = noteList;
              //           });
              //         });
              //       });
              // },
              //     child:Text("delete")),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NoteItem(notes[index]["id"],notes[index]["note"],DateTime.now());
                },
                itemCount: notes.length,),
            ],
          );

      }
        else return CircularProgressIndicator();

      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return edit();
          },));
        },
        child: Icon(Icons.add),),

    );
  }
}
