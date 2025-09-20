import 'package:equatable/equatable.dart';

class FreelanceModel extends Equatable {
  final String id;
  final String name;
  final String job;
  final String category;
  final String imagePath;
  final double rating;
  final int completedJobs;
  final bool isTopRated;
  final bool isFeatured;
  final bool isNew;
  final List<String> skills;
  final double hourlyRate;
  final String description;
  final int responseTime; // temps de réponse en heures

  const FreelanceModel({
    required this.id,
    required this.name,
    required this.job,
    required this.category,
    required this.imagePath,
    this.rating = 0.0,
    this.completedJobs = 0,
    this.isTopRated = false,
    this.isFeatured = false,
    this.isNew = false,
    this.skills = const [],
    this.hourlyRate = 0.0,
    this.description = '',
    this.responseTime = 24,
  });

  @override
  List<Object> get props => [
        id,
        name,
        job,
        category,
        imagePath,
        rating,
        completedJobs,
        isTopRated,
        isFeatured,
        isNew,
        skills,
        hourlyRate,
        description,
        responseTime,
      ];

  // ✅ NOUVELLE FACTORY : Convertir depuis le backend
  factory FreelanceModel.fromBackend(Map<String, dynamic> json) {
    return FreelanceModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      job: json['job'] as String,
      category: json['category'] as String,
      imagePath: json['imagePath'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedJobs: json['completedJobs'] as int? ?? 0,
      isTopRated: json['isTopRated'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? true,
      skills: json['skills'] != null ? List<String>.from(json['skills']) : [],
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      responseTime: json['responseTime'] as int? ?? 24,
    );
  }

  // Méthode factory pour créer une instance à partir d'un Map (JSON)
  factory FreelanceModel.fromJson(Map<String, dynamic> json) {
    return FreelanceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      job: json['job'] as String,
      category: json['category'] as String,
      imagePath: json['imagePath'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedJobs: json['completedJobs'] as int? ?? 0,
      isTopRated: json['isTopRated'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      responseTime: json['responseTime'] as int? ?? 24,
    );
  }

  // Méthode pour convertir l'instance en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'job': job,
      'category': category,
      'imagePath': imagePath,
      'rating': rating,
      'completedJobs': completedJobs,
      'isTopRated': isTopRated,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'skills': skills,
      'hourlyRate': hourlyRate,
      'description': description,
      'responseTime': responseTime,
    };
  }

  // Méthode pour créer une copie avec certains champs modifiés
  FreelanceModel copyWith({
    String? id,
    String? name,
    String? job,
    String? category,
    String? imagePath,
    double? rating,
    int? completedJobs,
    bool? isTopRated,
    bool? isFeatured,
    bool? isNew,
    List<String>? skills,
    double? hourlyRate,
    String? description,
    int? responseTime,
  }) {
    return FreelanceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      completedJobs: completedJobs ?? this.completedJobs,
      isTopRated: isTopRated ?? this.isTopRated,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      skills: skills ?? this.skills,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      description: description ?? this.description,
      responseTime: responseTime ?? this.responseTime,
    );
  }
}

// Données fictives pour les tests
List<FreelanceModel> getMockFreelancers() {
  return [
    const FreelanceModel(
      id: '1',
      name: 'Sali Diallo',
      job: 'Traductrice',
      category: 'Traduction',
      imagePath: 'assets/esty.jpg',
      rating: 4.8,
      completedJobs: 138,
      isTopRated: true,
      skills: ['Anglais', 'Français', 'Espagnol', 'Arabe'],
      hourlyRate: 25.0,
      description:
          'Traductrice professionnelle avec plus de 5 ans d\'expérience',
      responseTime: 2,
    ),
    const FreelanceModel(
      id: '2',
      name: 'Oumar Sy',
      job: 'Développeur',
      category: 'Dev',
      imagePath: 'assets/profile_picture.jpg',
      rating: 4.9,
      completedJobs: 256,
      isTopRated: true,
      isFeatured: true,
      skills: ['Flutter', 'React Native', 'Node.js', 'Python'],
      hourlyRate: 35.0,
      description: 'Développeur full-stack spécialisé en applications mobiles',
      responseTime: 1,
    ),
    const FreelanceModel(
      id: '3',
      name: 'Léa Touré',
      job: 'Community Manager',
      category: 'Marketing',
      imagePath: 'assets/coiffuer2.jpeg',
      rating: 4.7,
      completedJobs: 94,
      isNew: false,
      skills: ['Instagram', 'TikTok', 'Facebook Ads', 'Content Strategy'],
      hourlyRate: 28.0,
      description: 'Community Manager créative et orientée résultats',
      responseTime: 3,
    ),
    const FreelanceModel(
      id: '4',
      name: 'Ali Ndiaye',
      job: 'Designer UI/UX',
      category: 'Design',
      imagePath: 'assets/profile_picture.jpg',
      rating: 4.9,
      completedJobs: 189,
      isTopRated: true,
      isFeatured: true,
      skills: ['Figma', 'Adobe XD', 'Sketch', 'Prototypage'],
      hourlyRate: 40.0,
      description: 'Designer UI/UX avec approche centrée sur l\'utilisateur',
      responseTime: 4,
    ),
    const FreelanceModel(
      id: '5',
      name: 'Fatou Sow',
      job: 'Vidéaste',
      category: 'Vidéo',
      imagePath: 'assets/esty.jpg',
      rating: 4.6,
      completedJobs: 72,
      isNew: true,
      skills: [
        'Montage vidéo',
        'Motion Design',
        'After Effects',
        'Premiere Pro'
      ],
      hourlyRate: 30.0,
      description:
          'Vidéaste professionnelle spécialisée dans le marketing digital',
      responseTime: 6,
    ),
    const FreelanceModel(
      id: '6',
      name: 'Mamadou Diop',
      job: 'Rédacteur',
      category: 'Rédaction',
      imagePath: 'assets/profile_picture.jpg',
      rating: 4.5,
      completedJobs: 104,
      skills: ['SEO', 'Copywriting', 'Storytelling', 'Articles de blog'],
      hourlyRate: 22.0,
      description: 'Rédacteur web SEO avec expertise dans divers secteurs',
      responseTime: 5,
    ),
    const FreelanceModel(
      id: '7',
      name: 'Aminata Ba',
      job: 'Photographe',
      category: 'Photo',
      imagePath: 'assets/esty.jpg',
      rating: 4.7,
      completedJobs: 158,
      isTopRated: true,
      skills: ['Portrait', 'Produit', 'Événementiel', 'Retouche photo'],
      hourlyRate: 45.0,
      description:
          'Photographe professionnelle, spécialisation en photo commerciale',
      responseTime: 8,
    ),
  ];
}
