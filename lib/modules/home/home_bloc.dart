import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/modules/home/home_model.dart';
import 'home_repo.dart';
import 'home_controller.dart';

class HomeBloc extends Cubit<HomeController> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial());
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
