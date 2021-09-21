import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_client.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(HomeInitial());
  MovieModel? movies;

  Future<void> getMovies() async {
    try {
      emit(HomeLoading());
      await Future.delayed(Duration(milliseconds: 500));
      final dio = Dio();
      final client = RestClient(dio);
      movies = await client.getMovies();
      emit(HomeCompleted(movies!.results!));
    } on NetworkError catch (e) {
      emit(HomeError(e.message));
    }
  }
}
