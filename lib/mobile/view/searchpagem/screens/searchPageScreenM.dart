import 'package:flutter/material.dart';

class SearchPageScreenM extends StatefulWidget {
  const SearchPageScreenM({super.key});

  @override
  State<SearchPageScreenM> createState() => _SearchPageScreenMState();
}

class _SearchPageScreenMState extends State<SearchPageScreenM> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _arrowPressed = false;
  int _prestatairePressed = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Ajoute ici d'autres éléments de menu si besoin
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(44),
              bottomRight: Radius.circular(44),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44),
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
                        GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(Icons.menu,
                              color: Colors.white, size: 32),
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.white, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 700),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: child,
                    ),
                    child: const Center(
                      child: Text(
                        'SOUTRALI DEALS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Section navigation boutons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStyledNavButton(
                        'Prestation de service', Icons.settings),
                    _buildStyledNavButton('E-commerce', Icons.shopping_cart),
                    Stack(
                      children: [
                        _buildStyledNavButton(
                            'Crypto Store', Icons.currency_bitcoin),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.18),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Nouveau',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildStyledNavButton(
                        'Petite Annonce', Icons.alternate_email),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Animation fade pour Métiers
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: child,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Métiers',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildStyledCategoryItem('Maçonnerie', 'Catégorie',
                        'assets/categories/image1.png',
                        isPopular: true),
                    _buildStyledCategoryItem('Menuisier', 'Catégorie',
                        'assets/categories/image2.png'),
                    _buildStyledCategoryItem('Mécanique', 'Catégorie',
                        'assets/categories/image3.png'),
                    _buildStyledCategoryItem('Plomberie', 'Catégorie',
                        'assets/categories/image4.png'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Animation fade pour Prestataires
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: child,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Prestataires',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        height: 160,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              _buildStyledProviderItem('Marc', '1000 FCFA',
                                  'assets/profile_picture.jpg',
                                  isPopular: true, index: 0),
                              const SizedBox(width: 12),
                              _buildStyledProviderItem(
                                  'Elie', '1000 FCFA', 'assets/esty.jpg',
                                  index: 1),
                              const SizedBox(width: 12),
                              _buildStyledProviderItem('Tratra', '1000 FCFA',
                                  'assets/coiffuer2.jpeg',
                                  index: 2),
                              const SizedBox(width: 12),
                              _buildStyledProviderItem(
                                  'OLI', '1000 FCFA', 'assets/esty.jpg',
                                  index: 3),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledCategoryItem(
      String title, String subtitle, String imagePath,
      {bool isPopular = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {},
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.green.withOpacity(0.07)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
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
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTapDown: (_) => setState(() => _arrowPressed = true),
                        onTapUp: (_) => setState(() => _arrowPressed = false),
                        onTapCancel: () =>
                            setState(() => _arrowPressed = false),
                        child: AnimatedScale(
                          scale: _arrowPressed ? 1.15 : 1.0,
                          duration: Duration(milliseconds: 120),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isPopular)
                Positioned(
                  top: 10,
                  right: 10,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 600),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: child,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
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
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledProviderItem(String name, String price, String imagePath,
      {bool isPopular = false, required int index}) {
    final bool pressed = _prestatairePressed == index;
    return AnimatedScale(
      scale: pressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 120),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _prestatairePressed = index),
        onTapUp: (_) => setState(() => _prestatairePressed = -1),
        onTapCancel: () => setState(() => _prestatairePressed = -1),
        child: Container(
          width: 120,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green.withOpacity(0.08)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.10),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
              if (isPopular)
                BoxShadow(
                  color: Colors.orange.withOpacity(0.18),
                  blurRadius: 18,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              splashColor: Colors.green.withOpacity(0.08),
              onTap: () {},
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: isPopular
                              ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.25),
                                blurRadius: 18,
                                spreadRadius: 2,
                              ),
                            ],
                            shape: BoxShape.circle,
                          )
                              : null,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  if (isPopular)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: child,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Populaire',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
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
    );
  }

  Widget _buildStyledNavButton(String label, IconData icon) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: (_) {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.18),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(32),
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.transparent,
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 70,
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSearchBar extends StatefulWidget {
  @override
  State<_AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<_AnimatedSearchBar> {
  bool _focused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _focused ? 1.035 : 1.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
              color: _focused ? Colors.green : Colors.green.shade200,
              width: 1.4),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(_focused ? 0.13 : 0.07),
              blurRadius: _focused ? 18 : 10,
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
                child:
                Icon(Icons.search_rounded, color: Colors.white, size: 22),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                style: const TextStyle(fontSize: 16),
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  hintText: 'Rechercher sur soutralideals',
                  hintStyle: TextStyle(
                      color: Colors.green.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}