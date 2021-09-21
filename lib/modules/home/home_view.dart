import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_tracker/modules/details/details.dart';
import 'package:movie_tracker/modules/home/home_state.dart';
import 'package:get/get.dart';

import '../../helper.dart';
import 'home_controller.dart';

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
      BlocProvider.of<HomeController>(_context!).getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) {
        return HomeController();
      },
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: buildAppBar(),
        body: BlocConsumer<HomeController, HomeStates>(
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
              return buildListViewMovies(state, _context!);
            } else {
              return buildError(state);
            }
          },
        ),
      );
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: 20),
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      title: Text(
        "Most Popular Movies",
        style: t2(),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20),
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}

Text buildError(HomeStates state) {
  final error = state as HomeError;
  return Text(error.message);
}

Stack buildListViewMovies(HomeCompleted state, BuildContext context) {
  return Stack(
    children: [
      Container(
        height: screenH(1, context),
        width: screenW(1, context),
        child: Image.network(
          "https://www.themoviedb.org/t/p/w220_and_h330_face" +
              state.response[Random().nextInt(state.response.length)]
                  .backdropPath!,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: screenH(0.2, context)),
        height: screenH(0.5, context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(Details(
                r: state.response[index],
              ));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                        "https://www.themoviedb.org/t/p/w220_and_h330_face" +
                            state.response[index].posterPath!),
                  ),
                  Text(
                    state.response[index].title!.substring(
                        0,
                        state.response[index].title!.length > 18
                            ? 18
                            : state.response[index].title!.length),
                    style: t2(),
                  ),
                  Row(
                    children: [
                      Text(
                        state.response[index].releaseDate!.year.toString(),
                        maxLines: 2,
                        style: t1(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          itemCount: state.response.length,
        ),
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
      ],
    ),
  );
}
