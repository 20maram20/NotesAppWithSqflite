import 'package:flutter/material.dart';
import 'package:notes_app/view/edit.dart';
import 'package:notes_app/model/model.dart';
import 'package:notes_app/widgets/noteitem.dart';
import 'package:notes_app/sqldb.dart';
class home extends StatefulWidget {
   home({super.key});

  @override
  State<home> createState() => _homeState();

}

class _homeState extends State<home> {
  SqlDb sqlDb =SqlDb();
   late List<Map<String, dynamic>> notes;


  @override
  void initState() {
    sqlDb.intialDb();
    sqlDb.read("notes").then((noteList) {
      setState(() {
        notes = noteList;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body:Column(
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
