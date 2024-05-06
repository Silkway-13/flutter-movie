import 'package:flutter/material.dart';
import 'package:movieapp/Model/movie/index.dart';
import 'package:movieapp/screens/movie_detail.dart';

class MovieSpecialCard extends StatelessWidget {
  final MovieModel data;

  const MovieSpecialCard(this.data, {super.key});

  void _onCardTap(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MovieDetailPage(data)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    return InkWell(
        onTap: () => _onCardTap(context),
        child: Container(
          height: width * 1.5,
          width: width,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: NetworkImage(data.imgUrl), fit: BoxFit.cover),
          ),
          child: Icon(
            Icons.play_circle,
            color: Colors.grey.withOpacity(0.8),
            size: 60,
          ),
        ));
  }
}
