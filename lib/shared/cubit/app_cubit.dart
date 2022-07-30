import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../screens/dictionary_screen/dictionary_screen.dart';
import '../../screens/favorite_screen/favorite_screen.dart';
import '../../screens/random_word_screen/random_word_screen.dart';
import '../../screens/test_screen/test_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool alreadyExists = false;
  Database? database;
  List<Map> words = [];
  List<Map> shuffledWords = [];
  List<Map> searchResults = [];
  int num = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Widget> screens = [
    const DictionaryScreen(),
    const RandomWordScreen(),
    const TestScreen(),
    const FavoriteScreen(),
  ];
  List<String> titles = ['Dictionary', 'Random Words', 'Test', 'Favorite'];

  void shuffle() {
    late Set<int> randomNumbers = {};
    shuffledWords = [];
    if (words.length < 10) {
      while (randomNumbers.length < words.length) {
        randomNumbers.add(Random().nextInt(words.length));
      }
    } else if (words.length >= 10) {
      while (randomNumbers.length < 10) {
        randomNumbers.add(Random().nextInt(words.length));
      }
    }
    if (randomNumbers.isNotEmpty) {
      for (var element in randomNumbers) {
        shuffledWords.add(words[element]);
      }
    }
    emit(AppShuffleRandomWordState());
  }

  void testWord() {
    int temp = num;
    while (temp == num) {
      num = Random().nextInt(words.length);
    }
    emit(AppTestRandomWordState());
  }

  void favIconButton({required String status, required int id}) {
    updateData(status: status, id: id);
    emit(AppUpdateFavIconState());
  }

  void runFilter(String enteredKeyword) {
    searchResults = [];
    if (enteredKeyword.isEmpty) {
      searchResults = [];
    } else {
      searchResults = words
          .where((element) => element["englishWord"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    emit(AppSearchState());
  }

  void createDatabase() {
    openDatabase(
      'dictionary.db',
      version: 1,
      onCreate: (database, version) {
        print('Database created');
        database
            .execute(
                'CREATE TABLE Dictionary (id INTEGER PRIMARY KEY, englishWord TEXT, arabicWord Text, status Text)')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Error when creating table : ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('Database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getDataFromDataBase(database) {
    words = [];
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM Dictionary').then((value) {
      value.forEach(((element) {
        words.add(element);
      }));
      shuffle();
      emit(AppGetDatabaseState());
    }).catchError((error) {
      print('Error when getting data from database : ${error.toString()}');
    });
  }

  insertToDatabase({
    required String eWord,
    required String aWord,
  }) async {
    bool flag = false;
    alreadyExists = false;
    late String enWord;
    for (int i = 0; i < words.length; i++) {
      enWord = words[i]['englishWord'];
      if (eWord.toLowerCase() == enWord.toLowerCase()) {
        flag = true;
        break;
      }
    }
    if (flag == true) {
      alreadyExists = true;
    } else {
      await database!.transaction((txn) async {
        await txn
            .rawInsert(
                'INSERT INTO Dictionary(englishWord, arabicWord, status) VALUES("$eWord","$aWord","notFav")')
            .then((value) {
          print('$value Inserted successfully');
          emit(AppInsertDatabaseState());
          getDataFromDataBase(database);
        }).catchError((error) {
          print('Error when inserting new record : ${error.toString()}');
        });
        return;
      });
    }
  }

  void deleteData({required int id}) async {
    database!
        .rawDelete('DELETE FROM Dictionary WHERE ID = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteFromDatabaseState());
      print(value);
    }).catchError((error) {
      print('Error when delete record from database : ${error.toString()}');
    });
  }

  void updateData({required String status, required int id}) async {
    database!.rawUpdate(
      'UPDATE Dictionary SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseState());
      print(value);
    }).catchError((error) {
      print('Error when update record database : ${error.toString()}');
    });
  }
}
