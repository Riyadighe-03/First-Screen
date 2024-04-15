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
    Stream<AppState> mapEventToState(AppEvent event) async* {
      if (event is IncrementEvent) {
        yield UpdatedState(
            state is UpdatedState ? (state as UpdatedState).count + 1 : 1);
      } else if (event is DecrementEvent) {
        yield UpdatedState(
            state is UpdatedState ? (state as UpdatedState).count - 1 : -1);
      }
    }
  }
}
