import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationItem2 extends StatefulWidget {
  final String title;

  const NavigationItem2({required this.title, super.key});

  @override
  State<NavigationItem2> createState() => _NavigationItem2State();
}

class _NavigationItem2State extends State<NavigationItem2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          _animationController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _animationController.reverse();
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: GestureDetector(
                onTap: () {
                  if (widget.title == "Autres") {
                    context.go('/autre');
                  } else if (widget.title == "A propos") {
                    context.go('/apropos');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? const Color(0xFF1CBF3F).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: _isHovered
                        ? Border.all(
                            color: const Color(0xFF1CBF3F).withOpacity(0.3),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _isHovered
                          ? const Color(0xFF1CBF3F)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
