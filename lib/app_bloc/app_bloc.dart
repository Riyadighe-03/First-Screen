import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) {
      emit(UpdatedState(event.count + 1));
    });
    on<DecrementEvent>((event, emit) {
      emit(UpdatedState(event.count - 1));
    });
  }
}
