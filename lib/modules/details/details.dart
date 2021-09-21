import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie_tracker/helper.dart';
import 'package:movie_tracker/modules/home/api_client.dart';

class Details extends StatelessWidget {
  Details({this.r}) : super();

  Result? r;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                new Container(),
              ],
              leading: Container(
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
              ),
              expandedHeight: screenH(0.6, context),
              backgroundColor: lightColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(0),
                background: slidingArea(context),
              ),
            ),
          ];
        },
        body: bodyBuilder(),
      ),
    );
  }

  Stack slidingArea(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenW(1, context),
          height: screenH(0.55, context),
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            child: Image.network(
              "https://www.themoviedb.org/t/p/w220_and_h330_face" +
                  r!.backdropPath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: screenH(0.1, context),
              width: screenW(0.9, context),
              margin: EdgeInsets.only(bottom: screenH(0.05, context)),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [kDefaultShadow],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/star_fill.svg"),
                      Text(r!.voteAverage.toString() + "/10", style: t1()),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/star.svg"),
                      Text(
                        "Rate This",
                        style: t1(),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        color: shadowColorGreen,
                        child: Text(
                          r!.popularity!.toString().substring(0, 3),
                          style: buttonText(),
                        ),
                      ),
                      Text(
                        "Popularity",
                        style: t1(),
                      ),
                      Text(
                        r!.voteCount.toString() + " voted",
                        style: t3(),
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }

  SingleChildScrollView bodyBuilder() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            child: Text(
              r!.title.toString(),
              style: h3(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text(r!.releaseDate!.year.toString()),
                space(2),
                Text(r!.adult == true ? "PG +18" : "PG +10"),
                space(2),
                Text(r!.originalLanguage.toString()),
              ],
            ),
          ),
          space(16),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Summary",
              style: t2(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(16),
            child: Text(
              r!.overview.toString(),
              style: t1(),
            ),
          ),
        ],
      ),
    );
  }
}
