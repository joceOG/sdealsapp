import 'package:flutter/material.dart';

class SearchPageScreenM extends StatelessWidget {
  SearchPageScreenM({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        preferredSize: const Size.fromHeight(180),
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double horizontalPadding = 16.0;
                        double width =
                            constraints.maxWidth - 2 * horizontalPadding;
                        return Center(
                          child: Container(
                            width: width > 0 ? width : constraints.maxWidth,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.13),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                const Icon(Icons.search,
                                    color: Colors.grey, size: 26),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: TextField(
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'Rechercher sur soutralideals',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Material(
                                    color: Colors.white,
                                    shape: const CircleBorder(),
                                    elevation: 4,
                                    shadowColor: Colors.black.withOpacity(0.18),
                                    child: InkWell(
                                      customBorder: const CircleBorder(),
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.settings,
                                            color: Colors.grey, size: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                    _buildNavButton('Prestation de service', Icons.settings),
                    _buildNavButton('E-commerce', Icons.shopping_cart),
                    _buildNavButton('Crypto Store', Icons.currency_bitcoin),
                    _buildNavButton('Petite Annonce', Icons.alternate_email),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
              _buildCategoryItem(
                  'Maçonnerie', 'Catégorie', 'assets/categories/image1.png'),
              _buildCategoryItem(
                  'Menuisier', 'Catégorie', 'assets/categories/image2.png'),
              _buildCategoryItem(
                  'Mécanique', 'Catégorie', 'assets/categories/image3.png'),
              _buildCategoryItem(
                  'Plomberie', 'Catégorie', 'assets/categories/image4.png'),
              const SizedBox(height: 30),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProviderItem(
                        'Marc', '1000 FCFA', 'assets/profile_picture.jpg'),
                    _buildProviderItem('Elie', '1000 FCFA', 'assets/esty.jpg'),
                    _buildProviderItem(
                        'Tratra', '1000 FCFA', 'assets/coiffuer2.jpeg'),
                    _buildProviderItem('OLI', '1000 FCFA', 'assets/esty.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String subtitle, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderItem(String name, String price, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          price,
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildNavButton(String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.green, size: 32),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
