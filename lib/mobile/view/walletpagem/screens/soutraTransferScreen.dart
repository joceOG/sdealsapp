import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SoutraTransferScreen extends StatefulWidget {
  const SoutraTransferScreen({Key? key}) : super(key: key);

  @override
  State<SoutraTransferScreen> createState() => _SoutraTransferScreenState();
}

class _SoutraTransferScreenState extends State<SoutraTransferScreen> {
  // Contrôleurs pour les champs de texte
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();
  
  // Montant à transférer
  double amount = 0;
  
  // État du destinataire
  bool hasReceiver = false;
  
  // Formatteur pour le montant
  String get formattedAmount {
    if (amount == 0) return "0";
    final formatter = NumberFormat("#,##0", "fr_FR");
    return formatter.format(amount);
  }
  
  // Contacts récents fictifs
  final List<Map<String, dynamic>> recentContacts = [
    {
      "name": "Mariam Konaté",
      "phone": "+225 07 44 55 66",
      "avatar": "M",
      "color": Colors.purple,
    },
    {
      "name": "Jean Kouassi",
      "phone": "+225 05 12 34 56",
      "avatar": "J",
      "color": Colors.blue,
    },
    {
      "name": "Fatou Diallo",
      "phone": "+225 01 99 88 77",
      "avatar": "F",
      "color": Colors.orange,
    },
  ];
  
  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    _receiverController.dispose();
    super.dispose();
  }
  
  void _updateAmount(String digit) {
    setState(() {
      if (digit == "C") {
        // Effacer tout
        _amountController.text = "";
        amount = 0;
      } else if (digit == "⌫") {
        // Effacer le dernier chiffre
        if (_amountController.text.isNotEmpty) {
          _amountController.text = _amountController.text
              .substring(0, _amountController.text.length - 1);
          amount = _amountController.text.isEmpty
              ? 0
              : double.parse(_amountController.text);
        }
      } else {
        // Ajouter le chiffre si ça ne dépasse pas 7 caractères (limite de millions)
        if (_amountController.text.length < 7) {
          _amountController.text += digit;
          amount = double.parse(_amountController.text);
        }
      }
    });
  }
  
  void _selectContact(Map<String, dynamic> contact) {
    setState(() {
      _receiverController.text = "${contact['name']} (${contact['phone']})";
      hasReceiver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Envoyer de l\'argent',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Zone de saisie destinataire
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Destinataire",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _receiverController,
                  readOnly: true,
                  onTap: () => _showReceiverSelectionModal(),
                  decoration: InputDecoration(
                    hintText: "Ajouter un destinataire",
                    prefixIcon: const Icon(Icons.person_outline),
                    suffixIcon: hasReceiver
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _receiverController.text = "";
                                hasReceiver = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _showReceiverSelectionModal(),
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ),
              ],
            ),
          ),
          
          // Zone du montant
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Affichage du montant
                  Text(
                    "$formattedAmount FCFA",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Champ pour le commentaire
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Ajouter un commentaire (optionnel)",
                      prefixIcon: const Icon(Icons.message_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.emoji_emotions_outlined),
                        onPressed: () {
                          // Ouvrir le sélecteur d'emoji
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Clavier numérique personnalisé
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      _buildKeypadButton("1"),
                      _buildKeypadButton("2"),
                      _buildKeypadButton("3"),
                      _buildKeypadButton("4"),
                      _buildKeypadButton("5"),
                      _buildKeypadButton("6"),
                      _buildKeypadButton("7"),
                      _buildKeypadButton("8"),
                      _buildKeypadButton("9"),
                      _buildKeypadButton("C"),
                      _buildKeypadButton("0"),
                      _buildKeypadButton("⌫"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bouton d'envoi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: (amount > 0 && hasReceiver) ? _confirmTransfer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Envoyer maintenant",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Bouton du clavier numérique personnalisé
  Widget _buildKeypadButton(String digit) {
    return InkWell(
      onTap: () => _updateAmount(digit),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: digit == "C" ? Colors.red.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: digit == "C" 
                ? Colors.red.withOpacity(0.3) 
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: digit == "⌫"
              ? const Icon(Icons.backspace_outlined)
              : Text(
                  digit,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: digit == "C" ? Colors.red : Colors.black87,
                  ),
                ),
        ),
      ),
    );
  }
  
  // Affiche la modal pour sélectionner un destinataire
  void _showReceiverSelectionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sélectionner un destinataire",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un contact",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Contacts récents",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: recentContacts.length,
                itemBuilder: (context, index) {
                  final contact = recentContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: contact["color"],
                      child: Text(
                        contact["avatar"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      contact["name"],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(contact["phone"]),
                    onTap: () {
                      _selectContact(contact);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Ajouter un nouveau contact
              },
              icon: const Icon(Icons.add),
              label: const Text("Nouveau contact"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Confirme le transfert
  void _confirmTransfer() {
    // Afficher la confirmation avant envoi
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmer le transfert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  const TextSpan(text: "Montant: "),
                  TextSpan(
                    text: "$formattedAmount FCFA",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  const TextSpan(text: "Destinataire: "),
                  TextSpan(
                    text: _receiverController.text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (_commentController.text.isNotEmpty) ...[
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                  children: [
                    const TextSpan(text: "Commentaire: "),
                    TextSpan(
                      text: _commentController.text,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              // Traiter le transfert
              Navigator.pop(context);
              _showSuccessDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );
  }
  
  // Affiche un message de succès
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 70,
            ),
            const SizedBox(height: 16),
            const Text(
              "Transfert réussi !",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Vous avez envoyé $formattedAmount FCFA",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Fermer la boîte de dialogue
              Navigator.pop(context);
              // Revenir à l'écran principal
              Navigator.pop(context);
            },
            child: const Text("Terminer"),
          ),
        ],
      ),
    );
  }
}
