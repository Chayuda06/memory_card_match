import 'package:flutter/material.dart';
import 'level_selection_screen.';

void main() {
  runApp(const MemoryGameApp());
}

class MemoryGameApp  StatelessWidget {
  const MemoryGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LevelSelectionScreen(), // เริ่มต้นที่หน้าเลือกเลเวล
    );
  }
}
