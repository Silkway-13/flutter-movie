import 'package:flutter/material.dart';
import 'package:movieapp/Model/movie/index.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel data;
  const MovieDetailPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 36, 40),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(data.title),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  // fit: StackFit.expand,
                  children: [
                    Image.network(
                      data.imgUrl,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_circle,
                            color: Colors.grey.withOpacity(0.9),
                            size: 60,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            data.title,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${data.publishedYear} | ${data.durationMin} | ${data.type}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                    SafeArea(
                        child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ))
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Тайлбар",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.description ?? " ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
