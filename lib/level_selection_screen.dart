import 'package:flutter/material.dart';
import 'game_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลัง
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ground.jpg'), // พื้นหลังน่ารัก
                fit: BoxFit.cover,
              ),
            ),
          ),

          // เนื้อหาหลัก (ปุ่มเลือก Level)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "เลือกระดับความยาก",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: 5, color: Colors.black45, offset: Offset(2, 2))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildLevelButton(context, "Level 1", Colors.pinkAccent, 1),
                SizedBox(height: 20),
                _buildLevelButton(context, "Level 2", Colors.orangeAccent, 2),
                SizedBox(height: 20),
                _buildLevelButton(context, "Level 3", Colors.blueAccent, 3),
                SizedBox(height: 30),
                _buildLevelButton(context, "Level 4", Colors.pinkAccent, 4),
                SizedBox(height: 20),
                _buildLevelButton(context, "Level 5", Colors.orangeAccent, 5),
                SizedBox(height: 20),
              ],
            ),
          ),

          // ✅ เพิ่มเครดิตที่มุมล่างขวา
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Create by Chayuda",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  shadows: [
                    Shadow(blurRadius: 3, color: Colors.black45, offset: Offset(1, 1))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, String text, Color color, int level) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameScreen(level: level)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black45,
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
