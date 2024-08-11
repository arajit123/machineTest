import 'package:flutter/material.dart';

class IconRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconWithText('Mobile', Icons.phone_android),
        _buildIconWithText('Laptop', Icons.laptop),
        _buildIconWithText('Camera', Icons.camera_alt),
        _buildIconWithText('LED', Icons.lightbulb),
      ],
    );
  }

  Widget _buildIconWithText(String text, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60, // Adjust the size to fit the gradient and icon
          height: 60, // Adjust the size to fit the gradient and icon
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: _getGradientForIcon(text),
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  Gradient _getGradientForIcon(String text) {
    switch (text) {
      case 'Mobile':
        return LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[300]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Laptop':
        return LinearGradient(
          colors: [Colors.green[700]!, Colors.green[300]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Camera':
        return LinearGradient(
          colors: [Colors.pink[700]!, Colors.pink[300]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'LED':
        return LinearGradient(
          colors: [Colors.orange[700]!, Colors.orange[300]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return LinearGradient(
          colors: [Colors.grey[700]!, Colors.grey[300]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }
}
