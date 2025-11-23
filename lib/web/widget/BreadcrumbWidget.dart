import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreadcrumbItem {
  final String label;
  final String? route;

  const BreadcrumbItem({required this.label, this.route});
}

class BreadcrumbWidget extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const BreadcrumbWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: Colors.grey[50],
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ),
            _buildItem(context, items[i], i == items.length - 1),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, BreadcrumbItem item, bool isLast) {
    if (isLast) {
      return Text(
        item.label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1CBF3F),
        ),
      );
    }

    return InkWell(
      onTap: item.route != null ? () => context.go(item.route!) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          item.label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
