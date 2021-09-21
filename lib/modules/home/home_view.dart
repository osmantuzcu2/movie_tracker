import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_tracker/modules/home/home_controller.dart';

import 'home_bloc.dart';
import 'home_repo.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(_context!).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) {
        return HomeBloc(HomeService());
      },
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Most Populer Movies"),
        ),
        body: BlocConsumer<HomeBloc, HomeController>(
          listener: (c, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (c, state) {
            _context = c;
            if (state is HomeInitial) {
              return buildCenterInitialChild(context);
            } else if (state is HomeLoading) {
              return buildCenterLoading();
            } else if (state is HomeCompleted) {
              return buildListViewCats(state, _context!);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(HomeController state) {
    final error = state as HomeError;
    return Text(error.message);
  }

  Stack buildListViewCats(HomeCompleted state, BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Image.network(
                "https://www.themoviedb.org/t/p/w220_and_h330_face" +
                    state.response[index].posterPath!),
            subtitle: Text(state.response[index].title!),
          ),
          itemCount: state.response.length,
        ),
      ],
    );
  }

  Center buildCenterLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Thanks for your patience..."),
          buildFloatingActionButtonCall(context)
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.clear_all),
      onPressed: () {
        BlocProvider.of<HomeBloc>(_context!).getMovies();
      },
    );
  }
}
