import 'package:flutter/material.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/appbarItem.dart';

class NavigationItem extends StatefulWidget {
  final String title;
  final VoidCallback? onTap; // Optionnel : Si présent, c'est un lien simple

  const NavigationItem({
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem>
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espacement réduit mais constant
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
                child: widget.onTap != null
                    ? GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold, // Harmonisé avec AppbarItem
                            color: _isHovered
                                ? const Color(0xFF1CBF3F)
                                : const Color(0xFF1E293B),
                          ),
                        ),
                      )
                    : AppbarItem(
                        title: widget.title,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold, // Harmonisé
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
