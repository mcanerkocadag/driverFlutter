import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MatchesView extends StatefulWidget {
  @override
  _MatchesViewState createState() => _MatchesViewState();
}

class _MatchesViewState extends State<MatchesView> {
  List<ImageData> _imageList = [
    ImageData(imageUrl: 'https://picsum.photos/id/237/200/300', likes: 10),
    ImageData(imageUrl: 'https://picsum.photos/id/238/200/300', likes: 15),
    ImageData(imageUrl: 'https://picsum.photos/id/239/200/300', likes: 20),
    ImageData(imageUrl: 'https://picsum.photos/id/240/200/300', likes: 5),
    ImageData(imageUrl: 'https://picsum.photos/id/241/200/300', likes: 7),
    ImageData(imageUrl: 'https://picsum.photos/id/242/200/300', likes: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Images',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the heart icon to like an image',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: 0.65, // boyut oranı
                        mainAxisSpacing: 5.0, // ana eksen aralığı
                        crossAxisSpacing: 5.0, // çapraz eksen aralığı
                        // öğelerin sabit yüksekliği
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 4 / 150,
                      ),
                      itemCount: _imageList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _imageList[index].imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, left: 16),
                                      child: Text(
                                        '${_imageList[index].likes} Likes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 2.0,
                                          sigmaY: 2.0,
                                        ),
                                        child: Container(
                                          color: Colors.black54,
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.thumb_up),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      _imageList[index].likes++;
                                                    });
                                                  },
                                                ),
                                                VerticalDivider(
                                                  thickness: 1,
                                                  color: Colors.white38,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.thumb_down),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      _imageList[index].likes--;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}

class ImageData {
  final String imageUrl;
  int likes;

  ImageData({required this.imageUrl, required this.likes});
}
