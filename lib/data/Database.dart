import 'dart:io';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Get the location of our app directory. This is where files for our app,
    // and only our app, are stored. Files in this directory are deleted
    // when the app is deleted.
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {
    }, onCreate: (Database db, int version) async {
      // Create the note table
      await db.execute('''
                CREATE TABLE contact(
                    id INTEGER PRIMARY KEY,
                    first_name TEXT DEFAULT '',
                    last_name TEXT DEFAULT '',
                    profile_pic TEXT DEFAULT '',
                    favorite BOOLEAN '',
                    primary_contact_no TEXT DEFAULT '',
                    rating DOUBLE,
                    email_address TEXT DEFAULT '',
                    qualification TEXT DEFAULT '',
                    description TEXT DEFAULT '',
                    specialization TEXT DEFAULT '',
                    languagesKnown TEXT DEFAULT '',                    
                    gender TEXT DEFAULT '',                    
                    blood_group TEXT DEFAULT '',                    
                    height TEXT DEFAULT '',                    
                    weight TEXT DEFAULT '',                    
                    dob TEXT DEFAULT '',                    
                    isEdited BOOLEAN ''                    
                )
            ''');
    });
  }

  newNote(DoctorListResponseModel note) async {
    final db = await database;
    var res = await db.insert('contact', note.toJson());

    return res;
  }

  Future<List<DoctorListResponseModel>> getNotes() async {
    final db = await database;
    var res = await db.query('contact',orderBy: "rating DESC");
    List<DoctorListResponseModel> notes = res.isNotEmpty ? res.map((note) => DoctorListResponseModel.fromJson(note)).toList() : null;

    return notes;
  }

  updateNote(DoctorListResponseModel note) async {
    final db = await database;
    var res = await db.update('contact', note.toJson(), where: 'id = ?', whereArgs: [note.id]);

    return res;
  }

}