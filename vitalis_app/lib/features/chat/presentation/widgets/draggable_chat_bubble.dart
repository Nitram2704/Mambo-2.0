import 'package:flutter/material.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class DraggableChatBubble extends StatefulWidget {
  final VoidCallback onTap;
  final bool isOpen;

  const DraggableChatBubble({
    super.key,
    required this.onTap,
    required this.isOpen,
  });

  @override
  State<DraggableChatBubble> createState() => _DraggableChatBubbleState();
}

class _DraggableChatBubbleState extends State<DraggableChatBubble> {
  Offset? _position;
  Offset _startPosition = Offset.zero;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Initialize position to bottom-right if not set yet
    if (_position == null) {
      _position = Offset(size.width - 76, size.height - 160);
    }

    return Positioned(
      left: _position!.dx,
      top: _position!.dy,
      child: GestureDetector(
        onPanStart: (details) {
          _startPosition = _position!;
          _isDragging = true;
        },
        onPanUpdate: (details) {
          setState(() {
            double nextX = _position!.dx + details.delta.dx;
            double nextY = _position!.dy + details.delta.dy;

            // Clamp positions to stay inside visible screen area
            nextX = nextX.clamp(16.0, size.width - 72.0);
            nextY = nextY.clamp(80.0, size.height - 150.0);

            _position = Offset(nextX, nextY);
          });
        },
        onPanEnd: (details) {
          _isDragging = false;
          // Calculate drag distance
          final distance = (_position! - _startPosition).distance;
          // If the drag distance is minimal, treat it as a tap
          if (distance < 5.0) {
            widget.onTap();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: widget.isOpen ? AppColors.accent : const Color(0xFF1E1E1E),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            widget.isOpen ? Icons.close : Icons.chat_bubble_outline,
            color: widget.isOpen ? Colors.black : AppColors.accent,
            size: 26,
          ),
        ),
      ),
    );
  }
}
