import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ProviderPlanningScreen extends StatefulWidget {
  const ProviderPlanningScreen({Key? key}) : super(key: key);

  @override
  _ProviderPlanningScreenState createState() => _ProviderPlanningScreenState();
}

class _ProviderPlanningScreenState extends State<ProviderPlanningScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Données simulées pour les événements du calendrier
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Initialiser quelques événements de test
    _initEvents();
  }

  void _initEvents() {
    // Aujourd'hui
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    // Demain
    final tomorrow = today.add(const Duration(days: 1));
    final tomorrowDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    
    // Dans 3 jours
    final inThreeDays = today.add(const Duration(days: 3));
    final inThreeDaysDate = DateTime(inThreeDays.year, inThreeDays.month, inThreeDays.day);
    
    // Dans 5 jours
    final inFiveDays = today.add(const Duration(days: 5));
    final inFiveDaysDate = DateTime(inFiveDays.year, inFiveDays.month, inFiveDays.day);
    
    _events[todayDate] = [
      Event(
        'Réparation plomberie',
        'Cocody - Villa 24',
        '09:00 - 11:00',
        Colors.blue,
        EventType.mission,
      ),
      Event(
        'Indisponibilité personnelle',
        'Rendez-vous médical',
        '14:00 - 16:00',
        Colors.red,
        EventType.unavailability,
      ),
    ];
    
    _events[tomorrowDate] = [
      Event(
        'Installation climatisation',
        'Marcory - Résidence Palm',
        '10:00 - 13:00',
        Colors.blue,
        EventType.mission,
      ),
    ];
    
    _events[inThreeDaysDate] = [
      Event(
        'Dépannage électrique',
        'Yopougon - Cité SIR',
        '08:00 - 10:00',
        Colors.blue,
        EventType.mission,
      ),
      Event(
        'Formation technique',
        'Centre de formation Soutrali',
        '15:00 - 17:00',
        Colors.green,
        EventType.training,
      ),
    ];
    
    _events[inFiveDaysDate] = [
      Event(
        'Indisponible - weekend',
        'Repos',
        'Toute la journée',
        Colors.red,
        EventType.unavailability,
      ),
    ];
  }

  List<Event> _getEventsForDay(DateTime day) {
    final eventDay = DateTime(day.year, day.month, day.day);
    return _events[eventDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                markerSize: 8,
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isEmpty) return null;
                  
                  // Différentes couleurs pour différents types d'événements
                  final colors = events.map((e) => (e as Event).color).toSet().toList();
                  
                  return Positioned(
                    bottom: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: colors.map((color) => Container(
                        width: 7,
                        height: 7,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      )).toList(),
                    ),
                  );
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonTextStyle: const TextStyle(fontSize: 14),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.blue),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.blue),
                formatButtonShowsNext: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDay == null 
                      ? 'Aujourd\'hui' 
                      : DateFormat('dd MMMM yyyy', 'fr_FR').format(_selectedDay!),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _buildLegendItem('Missions', Colors.blue),
                    const SizedBox(width: 8),
                    _buildLegendItem('Indisponibilité', Colors.red),
                    const SizedBox(width: 8),
                    _buildLegendItem('Formation', Colors.green),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _selectedDay == null
                ? _buildNoEventSelectedView()
                : _buildEventsForSelectedDay(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEventDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildNoEventSelectedView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Sélectionnez une date pour voir vos événements',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Ajouter un événement'),
            onPressed: () {
              _showAddEventDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsForSelectedDay() {
    final selectedEvents = _getEventsForDay(_selectedDay!);
    
    if (selectedEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun événement pour cette date',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un événement'),
              onPressed: () {
                _showAddEventDialog();
              },
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(Event event) {
    IconData iconData;
    
    switch (event.type) {
      case EventType.mission:
        iconData = Icons.handyman;
        break;
      case EventType.unavailability:
        iconData = Icons.block;
        break;
      case EventType.training:
        iconData = Icons.school;
        break;
      default:
        iconData = Icons.event;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: event.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          _showEventDetailsDialog(event);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: event.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  iconData,
                  color: event.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: event.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event.timeRange,
                            style: TextStyle(
                              fontSize: 12,
                              color: event.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (event.location.isNotEmpty) Text(
                      event.location,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (event.type == EventType.mission) TextButton.icon(
                          icon: const Icon(Icons.chat, size: 16),
                          label: const Text('Contacter'),
                          onPressed: () {
                            // Contacter le client
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text('Modifier'),
                          onPressed: () {
                            // Modifier l'événement
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetailsDialog(Event event) {
    IconData iconData;
    String typeLabel;
    
    switch (event.type) {
      case EventType.mission:
        iconData = Icons.handyman;
        typeLabel = 'Mission';
        break;
      case EventType.unavailability:
        iconData = Icons.block;
        typeLabel = 'Indisponibilité';
        break;
      case EventType.training:
        iconData = Icons.school;
        typeLabel = 'Formation';
        break;
      default:
        iconData = Icons.event;
        typeLabel = 'Événement';
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Entête
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: event.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      typeLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        event.timeRange,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Corps
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.location.isNotEmpty) Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (event.location.isNotEmpty) const SizedBox(height: 16),
                  
                  if (event.type == EventType.mission) ...[
                    const Text(
                      'Détails de la mission',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailItem('Client', 'Jean Konan', Icons.person),
                    _buildDetailItem('Contact', '+225 07 XX XX XX', Icons.phone),
                    _buildDetailItem('Budget', '25,000 FCFA', Icons.payments),
                    _buildDetailItem('Durée estimée', '2 heures', Icons.timer),
                  ],
                  
                  if (event.type == EventType.unavailability) ...[
                    const Text(
                      'Raison',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Indisponibilité personnelle pour rendez-vous médical.',
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                  
                  if (event.type == EventType.training) ...[
                    const Text(
                      'Détails de la formation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailItem('Formateur', 'Amadou Diallo', Icons.person),
                    _buildDetailItem('Sujet', 'Nouvelles techniques de plomberie', Icons.subject),
                    _buildDetailItem('Durée', '2 heures', Icons.timer),
                  ],
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fermer'),
          ),
          if (event.type == EventType.mission) ElevatedButton.icon(
            icon: const Icon(Icons.gps_fixed, size: 16),
            label: const Text('Itinéraire'),
            onPressed: () {
              Navigator.pop(context);
              // Ouvrir l'itinéraire sur la carte
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog() {
    final selectedDate = _selectedDay ?? DateTime.now();
    EventType selectedType = EventType.mission;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Ajouter un événement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date sélectionnée
                Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // Type d'événement
                const Text('Type d\'événement'),
                const SizedBox(height: 8),
                SegmentedButton<EventType>(
                  segments: const [
                    ButtonSegment(
                      value: EventType.mission,
                      label: Text('Mission'),
                      icon: Icon(Icons.handyman),
                    ),
                    ButtonSegment(
                      value: EventType.unavailability,
                      label: Text('Indisponible'),
                      icon: Icon(Icons.block),
                    ),
                    ButtonSegment(
                      value: EventType.training,
                      label: Text('Formation'),
                      icon: Icon(Icons.school),
                    ),
                  ],
                  selected: {selectedType},
                  onSelectionChanged: (Set<EventType> selection) {
                    setState(() {
                      selectedType = selection.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Titre
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Localisation
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Lieu',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Heure de début
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Heure début',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Heure fin',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (selectedType == EventType.mission) ...[
                  const SizedBox(height: 16),
                  const Text('Détails de la mission'),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Budget',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.payments),
                    ),
                  ),
                ],
                
                if (selectedType == EventType.unavailability) ...[
                  const SizedBox(height: 16),
                  const Text('Raison de l\'indisponibilité'),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Raison',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.info_outline),
                    ),
                    maxLines: 3,
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Ajouter l'événement
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Événement ajouté au calendrier'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String location;
  final String timeRange;
  final Color color;
  final EventType type;

  Event(this.title, this.location, this.timeRange, this.color, this.type);
}

enum EventType {
  mission,
  unavailability,
  training,
}
