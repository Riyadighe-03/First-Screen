part of 'app_bloc.dart';

class AppEvent {}

class IncrementEvent extends AppEvent {
  final int count;
  IncrementEvent(this.count);
}

class DecrementEvent extends AppEvent {
  final int count;
  DecrementEvent(this.count);
}
