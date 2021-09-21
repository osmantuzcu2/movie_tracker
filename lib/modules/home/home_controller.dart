import 'package:flutter/foundation.dart';
import 'package:movie_tracker/modules/home/home_model.dart';

abstract class HomeController {
  const HomeController();
}

class HomeInitial extends HomeController {
  const HomeInitial();
}

class HomeLoading extends HomeController {
  const HomeLoading();
}

class HomeCompleted extends HomeController {
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

class HomeError extends HomeController {
  final String message;
  const HomeError(this.message);
}
