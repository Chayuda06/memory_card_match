import 'package:flutter/material.dart';
import 'dart:async';
import 'card_model.dart';
import 'card_widget.dart';

class GameScreen extends StatefulWidget {
  final int level;

  GameScreen({required this.level});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> cards = [];
  List<int> selectedCards = [];
  int score = 0;
  int timeLeft = 90;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _startTimer();
  }

  void _initializeGame() {
    List<String> images = [
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/dca22f66668545.612885911b21a.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/0f5e1466668545.612885911ae29.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/caebd966668545.612885919a00a.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/3ab78566668545.612885919ad84.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/b2e7c766668545.61288590baf07.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/ab2dc866668545.612885919a6e7.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/4199ff66668545.61288590ba6e8.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/e0c18266668545.61288590baada.png',
      'https://mir-s3-cdn-cf.behance.net/project_modules/disp/d41a1866668545.612885911a9b1.png'
    ];

    int numPairs;
    if (widget.level == 1) {
      numPairs = 5;
      timeLeft = 90;
    } else if (widget.level == 2) {
      numPairs = 6;
      timeLeft = 80;
    } else if (widget.level == 3) {
      numPairs = 7;
      timeLeft = 70;
    } else if (widget.level == 4) {
      numPairs = 10;
      timeLeft = 60;
    } else {
      numPairs = 11;
      timeLeft = 50;
    }

    cards = (images.take(numPairs).toList() + images.take(numPairs).toList())
        .map((imageUrl) => CardModel(imageUrl: imageUrl))
        .toList();
    cards.shuffle();
    score = 0;
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });

        if (_allPairsMatched()) {
          timer.cancel();
          _showSuccessDialog();
        }
      } else {
        timer.cancel();
        _showTimeUpDialog();
      }
    });
  }

  void _onCardSelected(int index) {
    if (selectedCards.length < 2 && !cards[index].isMatched) {
      setState(() {
        selectedCards.add(index);
        cards[index].isFlipped = true;
      });

      if (selectedCards.length == 2) {
        _checkMatch();
      }
    }
  }

  void _checkMatch() async {
    await Future.delayed(Duration(seconds: 1));

    if (cards[selectedCards[0]].imageUrl == cards[selectedCards[1]].imageUrl) {
      setState(() {
        cards[selectedCards[0]].isMatched = true;
        cards[selectedCards[1]].isMatched = true;
        score += 10;
      });

      if (_allPairsMatched()) {
        timer?.cancel();
        _showSuccessDialog();
      }
    } else {
      setState(() {
        cards[selectedCards[0]].isFlipped = false;
        cards[selectedCards[1]].isFlipped = false;
        score -= 2;
      });
    }

    selectedCards.clear();
  }

  bool _allPairsMatched() {
    return cards.every((card) => card.isMatched);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(widget.level == 5 ? "ยินดีด้วย!" : "เยี่ยมมาก!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => Icon(Icons.star, color: Colors.yellow, size: 40)),
            ),
            SizedBox(height: 10),
            Text(widget.level == 5 ? "คุณเก่งมาก! ผ่านด่านสุดท้าย!" : "คุณจับคู่สำเร็จภายในเวลาที่กำหนด!"),
          ],
        ),
        actions: [
          if (widget.level < 5)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(level: widget.level),
                  ),
                );
              },
              child: Text("เล่นอีกครั้ง"),
            ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.level < 5) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(level: widget.level + 1),
                  ),
                );
              } else {
                Navigator.pop(context);  // Close dialog if on level 5
              }
            },
            child: Text(widget.level == 5 ? "เล่นอีกครั้ง" : "เล่นด่านต่อไป"),
          ),
        ],
      ),
    );
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("เวลาหมดแล้ว!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("คุณต้องการเล่นใหม่หรือไปยังด่านถัดไป?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(level: widget.level),
                ),
              );
            },
            child: Text("เล่นอีกครั้ง"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.level < 5) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(level: widget.level + 1),
                  ),
                );
              }
            },
            child: Text("เล่นด่านต่อไป"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 4; // Default value

    if (widget.level == 1) {
      crossAxisCount = 5; // 4 columns for level 1
    } else if (widget.level == 2) {
      crossAxisCount = 6; // 5 columns for level 2
    } else if (widget.level == 3) {
      crossAxisCount = 7; // 6 columns for level 3
    } else if (widget.level == 4) {
      crossAxisCount = 9; // 7 columns for level 4
    } else {
      crossAxisCount = 9; // 8 columns for level 5
    }

    return Scaffold(
      appBar: AppBar(title: Text("Memory Card Match - Level ${widget.level}")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Score: $score", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("เวลาที่เหลือ: $timeLeft วินาที", style: TextStyle(fontSize: 20, color: Colors.red)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4),  // เพิ่ม padding รอบๆ กรอบให้เล็กลง
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: GridView.builder(
                padding: EdgeInsets.all(4),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,  // ใช้ค่าที่ตั้งไว้ตามระดับ
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                    model: cards[index],
                    onTap: () => _onCardSelected(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
