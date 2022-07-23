part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomNavBarState extends AppState {}

class AppCreateDatabaseState extends AppState {}

class AppGetDatabaseLoadingState extends AppState {}

class AppGetDatabaseState extends AppState {}

class AppInsertDatabaseState extends AppState {}

class AppDeleteFromDatabaseState extends AppState {}

class AppShowDialogClosedState extends AppState {}

class AppShuffleRandomWordState extends AppState {}

class AppTestRandomWordState extends AppState {}

class AppUpdateDatabaseState extends AppState {}

class AppUpdateFavIconState extends AppState {}
class AppSearchState extends AppState {}
