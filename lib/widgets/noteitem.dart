import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/sqldb.dart';
class NoteItem extends StatelessWidget {
  final int id;

  final String title;
  final DateTime timestamp;

  late final String formattedTimestamp;

  NoteItem(this.id,this.title, this.timestamp) {
    formattedTimestamp = "${DateFormat('yyyy-MM-dd HH:mm').format(timestamp)}";
  }



   @override
  Widget build(BuildContext context) {
     SqlDb sqlDb =SqlDb();
     return ListTile(
      title: Text(title),
        subtitle: Text(formattedTimestamp),
      trailing: Container(
        width: 100,
        child: Row(
          children:
          [
            IconButton(
                onPressed: () {
               //   sqlDb.update('notes', values, mywhere);
                },
                icon:Icon(Icons.edit,color: Colors.blue,)),
            IconButton(onPressed: () {
             sqlDb.delete('notes', 'id = $id');
             sqlDb.read("notes");

            }, icon:Icon(Icons.delete,color: Colors.red,)),
          ],
        ),
      )
    );
  }
}
