import 'package:flutter/material.dart';
import 'card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel model;
  final VoidCallback onTap;

  CardWidget({required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.isFlipped || model.isMatched ? null : onTap, // ป้องกันการกดซ้ำ
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 3), // เพิ่มกรอบสีน้ำเงิน
          borderRadius: BorderRadius.circular(8),
          color: model.isMatched ? Colors.green[200] : Colors.white, // เปลี่ยนสีเมื่อจับคู่สำเร็จ
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0), // เพิ่มระยะขอบใน
          child: model.isFlipped || model.isMatched
              ? Image.network(model.imageUrl, width: 0.5, height: 0.5, fit: BoxFit.contain) // ปรับขนาดรูป
              : Container(
                  color: Colors.grey[300], // พื้นหลังเทาก่อนเปิดการ์ด
                  child: Center(
                    child: Icon(Icons.help, color: Colors.white, size: 40), // แสดงเครื่องหมายคำถาม
                  ),
                ),
        ),
      ),
    );
  }
}
