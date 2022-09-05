import 'package:ateliermastera/SQL/SavedUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedUserService {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'saved_users.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE saved_users(username TEXT NOT NULL,password TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(SavedUser user) async {
    final Database db = await initializeDB();
    db.insert('saved_users', user.toMap());
  }

  Future<SavedUser> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('saved_users');
    String? username, password;
    for(var result in queryResult){
      username = result['username'].toString();
      password = result['password'].toString();
    }
    return SavedUser(username: username.toString(), password: password.toString());
  }

  Future<void> delete() async {
    final db = await initializeDB();
    await db.delete('saved_users');
  }
}