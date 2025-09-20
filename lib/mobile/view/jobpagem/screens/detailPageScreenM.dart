import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:sdealsapp/mobile/view/common/widgets/ai_provider_matcher_widget.dart';
import 'package:sdealsapp/mobile/view/loginpagem/screens/loginPageScreenM.dart';
import 'package:sdealsapp/mobile/view/orderpagem/screens/service_request_summary_screen.dart';

// Page de détails de service (2025) avec header moderne, prestataires réels, et CTA sticky
class DetailPage extends StatefulWidget {
  final String title;
  final String image;

  const DetailPage({
    required this.title,
    required this.image,
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiClient _api = ApiClient();
  bool _loading = true;
  List<Map<String, dynamic>> _providers = [];
  bool _filterVerifiedOnly = false;
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    setState(() {
      _loading = true;
    });
    try {
      final results = await _api.fetchPrestatairesByService(
        serviceName: widget.title,
        verified: _filterVerifiedOnly ? true : null,
        limit: 10,
      );
      if (!mounted) return;
      setState(() {
        _providers = results;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur chargement prestataires: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_rounded),
            onPressed: _onShareTap,
          ),
          IconButton(
            icon: Icon(
              _isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
            onPressed: _onFavoriteTap,
          ),
          IconButton(
            icon: const Icon(Icons.flag_outlined),
            onPressed: _onReportTap,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServiceImage(widget.image),
                  const SizedBox(height: 16),
                  _buildHeaderChips(),
                  const SizedBox(height: 14),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Description du service :\nCe service est assuré par un professionnel qualifié.",
                    style: TextStyle(fontSize: 15.5, color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Colors.green, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Disponible à : Abobo",
                        style: TextStyle(fontSize: 14.5, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Note : 4.8/5",
                        style: TextStyle(fontSize: 14.5, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  AIProviderMatcherWidget(
                    serviceType: widget.title,
                    location: "Abidjan",
                    preferences: const [],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Prestataires disponibles',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _filterVerifiedOnly = !_filterVerifiedOnly;
                          });
                          _loadProviders();
                        },
                        icon: Icon(
                          _filterVerifiedOnly
                              ? Icons.verified_rounded
                              : Icons.verified_outlined,
                          color: Colors.green,
                        ),
                        label: Text(
                          _filterVerifiedOnly ? 'Vérifiés seulement' : 'Tous',
                          style: const TextStyle(color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_loading)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Center(
                    child: CircularProgressIndicator(color: Colors.green)),
              ),
            )
          else if (_providers.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text('Aucun prestataire trouvé pour ce service.'),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverList.builder(
                itemCount: _providers.length,
                itemBuilder: (context, index) {
                  final p = _providers[index];
                  return _buildProviderCard(p);
                },
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: _buildSuggestionsSection(context),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: _buildStickyCta(context),
    );
  }

  void _onShareTap() async {
    final text = 'Découvrez ${widget.title} sur Soutrali Deals';
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Texte copié dans le presse-papiers')),
    );
  }

  void _onFavoriteTap() {
    final auth = context.read<AuthCubit>().state;
    if (auth is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Connectez-vous pour ajouter en favoris.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPageScreenM()),
      );
      return;
    }

    setState(() => _isFavorited = !_isFavorited);
    final msg = _isFavorited ? 'Ajouté aux favoris' : 'Retiré des favoris';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

    // Appel backend (fire-and-forget)
    if (_isFavorited) {
      final token = auth.token;
      _api
          .addFavorite(
            token: token,
            title: widget.title,
            image: widget.image,
          )
          .catchError((e) => debugPrint('Erreur favoris: $e'));
    }
  }

  void _onReportTap() async {
    final controller = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Signaler le service'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Décrivez le problème…',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez saisir un motif.')),
                  );
                  return;
                }
                // envoyer au backend si connecté
                final auth = context.read<AuthCubit>().state;
                if (auth is AuthAuthenticated) {
                  try {
                    await _api.createReport(
                      token: auth.token,
                      targetType: 'SERVICE',
                      targetId: 'unknown',
                      reason: controller.text.trim(),
                    );
                    // succès
                  } catch (e) {
                    debugPrint('Erreur signalement: $e');
                  }
                }
                Navigator.pop(context, true);
              },
              child: const Text('Envoyer'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signalement envoyé. Merci.')),
      );
    }
  }

  Widget _buildStickyCta(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_checkout_rounded,
                color: Colors.white),
            label: const Text(
              "Commander ce service",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: () {
              final auth = context.read<AuthCubit>().state;
              if (auth is! AuthAuthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Veuillez vous connecter pour commander.')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPageScreenM()),
                );
                return;
              }
              _openCheckoutSheet();
            },
          ),
        ),
      ),
    );
  }

  void _openCheckoutSheet() {
    final adresseCtrl = TextEditingController();
    final villeCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    DateTime? selectedDateTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Commander ${widget.title}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: adresseCtrl,
                    decoration: const InputDecoration(labelText: 'Adresse'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: villeCtrl,
                    decoration: const InputDecoration(labelText: 'Ville'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(selectedDateTime == null
                            ? 'Date/heure non choisie'
                            : 'Le ${selectedDateTime!.toLocal()}'),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 90)),
                            initialDate:
                                DateTime.now().add(const Duration(days: 1)),
                          );
                          if (date == null) return;
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time == null) return;
                          final dt = DateTime(date.year, date.month, date.day,
                              time.hour, time.minute);
                          setSheetState(() => selectedDateTime = dt);
                        },
                        icon: const Icon(Icons.calendar_today,
                            color: Colors.green),
                        label: const Text('Choisir'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: notesCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () async {
                        final auth = context.read<AuthCubit>().state
                            as AuthAuthenticated;
                        try {
                          final created = await _api.createPrestation(
                            token: auth.token,
                            utilisateurId: auth.utilisateur.idutilisateur,
                            serviceId: null,
                            adresse: adresseCtrl.text.trim().isEmpty
                                ? null
                                : adresseCtrl.text.trim(),
                            ville: villeCtrl.text.trim().isEmpty
                                ? null
                                : villeCtrl.text.trim(),
                            dateHeure: selectedDateTime,
                            notesClient: notesCtrl.text.trim().isEmpty
                                ? null
                                : notesCtrl.text.trim(),
                            moyenPaiement: 'SOUTRAPAY',
                          );
                          if (!mounted) return;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Demande envoyée')));
                          final id = created['_id']?.toString();
                          if (id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ServiceRequestSummaryScreen(
                                  requestId: id,
                                  token: auth.token,
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erreur: $e')));
                        }
                      },
                      child: const Text('Confirmer et payer',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildServiceImage(String path) {
    final isUrl = path.toLowerCase().startsWith('http');
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: isUrl
          ? Image.network(
              path,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CircularProgressIndicator(color: Colors.green),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported,
                      size: 48, color: Colors.grey),
                );
              },
            )
          : Image.asset(
              path,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported,
                    size: 48, color: Colors.grey),
              ),
            ),
    );
  }

  Widget _buildHeaderChips() {
    final chips = <String>['Populaire', 'Rapide', 'Garanti', 'Top qualité'];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return FilterChip(
              label: const Text('Vérifiés'),
              selected: _filterVerifiedOnly,
              onSelected: (v) {
                setState(() => _filterVerifiedOnly = v);
                _loadProviders();
              },
            );
          }
          final label = chips[index - 1];
          return Chip(
            label: Text(label),
            backgroundColor: Colors.green.shade50,
            side: BorderSide(color: Colors.green.withOpacity(0.25)),
          );
        },
      ),
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> p) {
    final utilisateur = p['utilisateur'];
    final nom = (utilisateur is Map<String, dynamic>)
        ? '${utilisateur['nom'] ?? ''} ${utilisateur['prenom'] ?? ''}'.trim()
        : 'Prestataire';
    final service = p['service'];
    final serviceName = (service is Map<String, dynamic>)
        ? (service['nomservice'] ?? service['name'] ?? '')
        : (service?.toString() ?? '');
    final photo = (utilisateur is Map<String, dynamic>)
        ? (utilisateur['photoProfil'] ?? '')
        : '';
    final isUrl = photo.toString().toLowerCase().startsWith('http');
    final verified = p['verifier'] == true || p['verified'] == true;
    final price = p['prixprestataire']?.toString() ?? '-';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: isUrl && photo.isNotEmpty
                  ? Image.network(photo,
                      height: 56, width: 56, fit: BoxFit.cover)
                  : Container(
                      height: 56,
                      width: 56,
                      color: Colors.green.shade50,
                      alignment: Alignment.center,
                      child: const Icon(Icons.person, color: Colors.green),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          nom.isEmpty ? 'Prestataire' : nom,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (verified)
                        const Icon(Icons.verified_rounded,
                            color: Colors.green, size: 18),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    serviceName.toString(),
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12.5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      const Text('4.8'),
                      const SizedBox(width: 12),
                      const Icon(Icons.price_change_rounded,
                          size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Text('$price FCFA'),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Demande envoyée')));
              },
              child: const Text('Commander',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsSection(BuildContext context) {
    final suggestions = <String>[
      'Nettoyage ménager',
      'Collecte d\'encombrants',
      'Entretien espaces verts'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prestations similaires',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final label = suggestions[index];
              return ActionChip(
                label: Text(label),
                backgroundColor: Colors.green.shade50,
                side: BorderSide(color: Colors.green.withOpacity(0.3)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Suggestion: $label')),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
