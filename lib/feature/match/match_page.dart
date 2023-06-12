import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<String> cardTitles = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
    'Card 6',
    'Card 7',
    'Card 8',
    'Card 9',
    'Card 10',
  ];

  List<String> cardImages = [
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
    'assets/images/im_filmRecord.png',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  // Sağa swipe yapıldı
                  setState(() {
                    if (currentIndex > 0) {
                      currentIndex--;
                    }
                  });
                } else if (details.primaryVelocity! < 0) {
                  // Sola swipe yapıldı
                  setState(() {
                    if (currentIndex < cardTitles.length - 1) {
                      currentIndex++;
                    }
                  });
                }
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.asset(
                          cardImages[currentIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        cardTitles[currentIndex],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
