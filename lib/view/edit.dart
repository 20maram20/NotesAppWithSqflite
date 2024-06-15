import 'package:flutter/material.dart';
import 'package:notes_app/sqldb.dart';
import 'package:notes_app/view/home.dart';
class edit extends StatefulWidget {
   edit();

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController textEditingController=TextEditingController();
  SqlDb sqlDb =SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("add note" ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "note",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 10,),
            TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey)),
                onPressed: () {
              String noteText = textEditingController.text;
              if(noteText.isNotEmpty){
                sqlDb.insert("notes",
                    {
                      "note":noteText
                    }
                );
                sqlDb.read("notes");

              }
              sqlDb.read("notes");
              textEditingController.clear();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home(),),
                      (route) => false);

                }, child: Text("add note"))
          ],
        ),
      ),
    );
  }
}
