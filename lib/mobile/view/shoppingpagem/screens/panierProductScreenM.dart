import 'package:flutter/material.dart';

import 'confirmationCommandeScreenM.dart';

class PanierProductScreenM extends StatefulWidget {
  const PanierProductScreenM({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PanierProductScreenMState createState() => _PanierProductScreenMState();
}

class _PanierProductScreenMState extends State<PanierProductScreenM> {
  List<Map<String, dynamic>> produits = [
    {
      "image": "assets/adidas.jpg", // Remplacez par une vraie URL
      "nom": "Chaussure  Adidas Originals Superstar",
      "prix": 2590,
      "ancienPrix": 9000,
      "quantite": 1
    },
    {
      "image": "assets/adidas.jpg", // Remplacez par une vraie URL
      "nom": "Chaussure  Adidas Originals Superstar",
      "prix": 73000,
      "ancienPrix": null,
      "quantite": 1
    }
  ];

  double get total {
    return produits.fold(
        0, (sum, item) => sum + (item["prix"] * item["quantite"]));
  }

  void incrementerQuantite(int index) {
    setState(() {
      produits[index]["quantite"]++;
    });
  }

  void decrementerQuantite(int index) {
    setState(() {
      if (produits[index]["quantite"] > 1) {
        produits[index]["quantite"]--;
      } else {
        produits.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: produits.length,
              itemBuilder: (context, index) {
                var produit = produits[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.asset(
                      produit["image"],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(produit["nom"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (produit["ancienPrix"] != null)
                          Text(
                            "${produit["ancienPrix"]} FCFA",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                            ),
                          ),
                        Text("${produit["prix"]} FCFA",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.orange),
                          onPressed: () => decrementerQuantite(index),
                        ),
                        Text("${produit["quantite"]}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline,
                              color: Colors.green),
                          onPressed: () => incrementerQuantite(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$total FCFA",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // Logique de validation ici
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ConfirmationCommandeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Commander",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
