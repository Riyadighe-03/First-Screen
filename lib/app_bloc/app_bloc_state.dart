part of 'app_bloc.dart';

class AppState {}

class InitialState extends AppState {}

class UpdatedState extends AppState {
  final int count;

  UpdatedState(this.count);
}
