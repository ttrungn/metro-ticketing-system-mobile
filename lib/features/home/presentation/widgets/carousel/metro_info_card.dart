import 'package:flutter/material.dart';

class MetroInfoCard extends StatelessWidget {
  const MetroInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      // no shadow on card itself
      shadowColor: Colors.black,
      margin: EdgeInsets.all(5),
      // make card background transparent
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on top
          SizedBox(
            height: 140,
            width: 300,
            child: Image.asset('assets/icon/metro_pic.webp', fit: BoxFit.cover),
          ),

          // Title and subtitle text below image with padding
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'GO!METRO với đa dạng hình thức đi tàu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Nhấn để xem ngay bạn nhé',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
