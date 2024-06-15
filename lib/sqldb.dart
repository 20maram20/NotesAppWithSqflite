import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'cubit/notestate.dart';

class SqlDb extends Cubit<Notestate> {

  static Database? _db ;
  SqlDb():super(InitialState());


  Future<Database?> get db async {
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;
    }else {
      return _db ;
    }
  }


  intialDb() async {
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , 'test.db') ;
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;
    return mydb ;
  }
  _onUpgrade(Database db , int oldversion , int newversion ) async{
    print("onUpgrade =====================================") ;
    //await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }
  _onCreate(Database db , int version) async {
    Batch batch=db.batch();
    batch.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" TEXT NOT NULL
  )
 ''') ;
    //batch can make more than one table and its better awiatdb.excute idk why
 //    batch.execute('''
 //  CREATE TABLE "notes" (
 //    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
 //    "note" TEXT NOT NULL
 //  )
 // ''') ;
    await batch.commit();

    print(" onCreate =====================================") ;

  }

  readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response = await  mydb!.rawQuery(sql);
    emit(Readnote());
    return response ;
  }
  insertData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawInsert(sql);
    return response ;
  }
  updateData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete(sql);
    emit(Readnote());
    return response ;
  }

  mydeleteDatabase() async {
    String databasepath=await getDatabasesPath();
    String path=join(databasepath,'test.db');
    await  deleteDatabase(path);
  }
////////////////////////////////////////////////////////////////////////
  read(String table) async {
    emit(Readnote());

    Database? mydb = await db ;
    List<Map<String, Object?>> response = await  mydb!.query(table);
    return response ;
  }
  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db ;
    int  response = await  mydb!.insert(table,values);
    return response ;
  }
  update(String table, Map<String, Object?> values,String? mywhere) async {
    Database? mydb = await db ;
    int  response = await  mydb!.update(table,values,where: mywhere);
    return response ;
  }
  delete(String table,String? mywhere) async {
    Database? mydb = await db ;
    int  response = await  mydb!.delete(table,where: mywhere);
    return response ;
  }

// SELECT
// DELETE
// UPDATE
// INSERT
}