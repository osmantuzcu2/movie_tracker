import 'package:flutter/foundation.dart';
import 'package:movie_tracker/modules/home/home_model.dart';

abstract class HomeStates {
  const HomeStates();
}

class HomeInitial extends HomeStates {
  const HomeInitial();
}

class HomeLoading extends HomeStates {
  const HomeLoading();
}

class HomeCompleted extends HomeStates {
  final List<Result> response;

  const HomeCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class HomeError extends HomeStates {
  final String message;
  const HomeError(this.message);
}
