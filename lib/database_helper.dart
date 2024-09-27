import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'feriado.dart';

class DatabaseHelper {
  static final DatabaseHelper _instancia = DatabaseHelper._interno();
  factory DatabaseHelper() => _instancia;
  static Database? _database;

  DatabaseHelper._interno();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializarDatabase();
    return _database!;
  }

  Future<Database> _inicializarDatabase() async {
    String path = join(await getDatabasesPath(), 'feriados.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE feriados(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, fecha TEXT, descripcion TEXT, urlImagen TEXT)",
        );
      },
    );
  }

  Future<void> insertarFeriado(Feriado feriado) async {
    final db = await database;
    await db.insert(
      'feriados',
      feriado.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Feriado>> obtenerFeriados() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('feriados');
    return List.generate(maps.length, (i) {
      return Feriado(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        fecha: maps[i]['fecha'],
        descripcion: maps[i]['descripcion'],
        urlImagen: maps[i]['urlImagen'],
      );
    });
  }
}
