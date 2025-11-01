import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  static Database? _database;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    if (!_isEncryptionInitialized) await initEncryption();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''

      CREATE TABLE IF NOT EXISTS track (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date STRING NOT NULL,
        length INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        is_now INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_date ON track(date)
    ''');
  }

  // final _storage = FlutterSecureStorage();
  final box = Hive.box('enc');
  Encrypter? _encrypter;
  IV? _iv;
  bool _isEncryptionInitialized = false;
  Future<void>? _initEncryptionFuture;

  Future<void> initEncryption() {
    if (_isEncryptionInitialized) return Future.value();
    if (_initEncryptionFuture != null) return _initEncryptionFuture!;

    _initEncryptionFuture = _actualInitEncryption();
    return _initEncryptionFuture!;
  }

  Future<void> _actualInitEncryption() async {
    if (_isEncryptionInitialized) return;
    final box = await Hive.openBox('enc');
    final keyBase64 =
        box.get('key') ?? (await _generateAndStoreKey(box));
    final ivBase64 =
        box.get('iv') ?? (await _generateAndStoreIv(box));

    final key = Key.fromBase64(keyBase64);
    _iv = IV.fromBase64(ivBase64);
    _encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    _isEncryptionInitialized = true;
  }

  Future<String> _generateAndStoreKey(box) async {
    final newKey = Key.fromSecureRandom(32).base64;
    await box.put('key', newKey);
    return newKey;
  }

  Future<String> _generateAndStoreIv(box) async {
    final newIv = IV.fromSecureRandom(16).base64;
    await box.put('iv', newIv);
    return newIv;
  }

  String encryptText(String plainText) {
    return _encrypter!.encrypt(plainText, iv: _iv).base64;
  }

  String decryptText(String encryptedText) {
    return _encrypter!.decrypt(Encrypted.fromBase64(encryptedText), iv: _iv);
  }

}