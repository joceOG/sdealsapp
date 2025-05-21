import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../morepageblocm/morePageBlocM.dart';

class MorePageScreenM extends StatefulWidget {
  const MorePageScreenM({super.key});
  @override
  State<MorePageScreenM> createState() => _MorePagePageScreenStateM();
}

class _MorePagePageScreenStateM extends State<MorePageScreenM> {
  @override
  void initState() {
    BlocProvider.of<MorePageBlocM>(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(165),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, color: Colors.white, size: 32),
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.white, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'SOUTRALI DEALS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: Colors.green.shade200, width: 1.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.07),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Material(
                                color: Colors.green,
                                shape: const CircleBorder(),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Icon(Icons.search_rounded,
                                      color: Colors.white, size: 22),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 16),
                                  cursorColor: Colors.green,
                                  decoration: InputDecoration(
                                    hintText: 'Rechercher sur soutralideals',
                                    hintStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _AnimatedCardWithBadge(
                    icon: Icons.article_rounded,
                    label: 'Soutra News',
                    badge: 'Nouveau',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _AnimatedCardWithBadge(
                    icon: Icons.account_balance_wallet_rounded,
                    label: 'Soutra Pay',
                    badge: 'Nouveau',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCardWithBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final Gradient gradient;
  const _AnimatedCardWithBadge({
    required this.icon,
    required this.label,
    this.badge,
    required this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedCardWithBadge> createState() => _AnimatedCardWithBadgeState();
}

class _AnimatedCardWithBadgeState extends State<_AnimatedCardWithBadge> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {},
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              height: 100,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: _pressed
                        ? Colors.greenAccent.withOpacity(0.25)
                        : Colors.black.withOpacity(0.10),
                    blurRadius: _pressed ? 24 : 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, color: Colors.white, size: 32),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.badge != null)
              Positioned(
                top: -12,
                right: 18,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCategoryItem(String title, String subtitle, String imagePath,
    {bool isPopular = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {},
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        subtitle,
                        style:
                        const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isPopular)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Populaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildProviderItem(String name, String price, String imagePath,
    {bool isPopular = false}) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
    elevation: 2,
    child: InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {},
      child: Stack(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
            child: Column(
              children: [
                AnimatedScale(
                  scale: 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage(imagePath),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
                Text(
                  price,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          if (isPopular)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Populaire',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}