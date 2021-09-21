import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/modules/home/home_model.dart';
import 'home_repo.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeStates> {
  final HomeRepository homeRepository;
  HomeController(this.homeRepository) : super(HomeInitial());
  MovieModel? movies;

  Future<void> getMovies() async {
    try {
      emit(HomeLoading());
      await Future.delayed(Duration(milliseconds: 500));
      movies = await homeRepository.getMovies();
      emit(HomeCompleted(movies!.results!));
    } on NetworkError catch (e) {
      emit(HomeError(e.message));
    }
  }
}
