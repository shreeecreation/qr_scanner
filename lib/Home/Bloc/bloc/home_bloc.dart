import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeQrCreateEvent>((event, emit) {
      emit(HomeQrCreateState());
    });
    on<HomeQrScanEvent>((event, emit) {
      emit(HomeQrScanState());
    });
    on<HomeInitialEvent>((event, emit) {
      emit(HomeInitial());
    });
  }
}
