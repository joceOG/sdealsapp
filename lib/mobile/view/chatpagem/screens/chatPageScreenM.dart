import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/conversation_model.dart';
import '../../../data/models/message_model.dart';
import '../chatpageblocm/chatPageBlocM.dart';
import '../chatpageblocm/chatPageEventM.dart';
import '../chatpageblocm/chatPageStateM.dart';

class ChatPageScreenM extends StatefulWidget {
  final String? conversationId;
  final String? participantId;
  final String? participantName;
  final String? participantImage;
  final ConversationType? type;
  
  const ChatPageScreenM({
    super.key,
    this.conversationId,
    this.participantId,
    this.participantName,
    this.participantImage,
    this.type,
  });

  @override
  State<ChatPageScreenM> createState() => _ChatPageScreenMState();
}

class _ChatPageScreenMState extends State<ChatPageScreenM> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  String _searchQuery = '';
  bool _arrowPressed = false;
  File? _selectedImage;
  int _prestatairePressed = -1;
  
  late ChatPageBlocM _chatBloc;
  
  // Méthode pour obtenir la couleur selon le type de conversation
  Color _getConversationColor(ConversationType type) {
    switch (type) {
      case ConversationType.prestataire:
        return Colors.indigo.shade600;
      case ConversationType.vendeur:
        return Colors.deepOrange.shade600;
      case ConversationType.freelance:
        return Colors.teal.shade600;
    }
  }
  
  // Méthode pour obtenir le label selon le type de conversation
  String _getConversationLabel(ConversationType type) {
    switch (type) {
      case ConversationType.prestataire:
        return 'Prestataire';
      case ConversationType.vendeur:
        return 'Vendeur';
      case ConversationType.freelance:
        return 'Freelance';
    }
  }
  
  // Méthode pour formater l'horodatage des messages
  String _formatMessageTime(DateTime timestamp) {
    // Format HH:MM
    final String hour = timestamp.hour.toString().padLeft(2, '0');
    final String minute = timestamp.minute.toString().padLeft(2, '0');
    
    // Vérifier si le message est d'aujourd'hui
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      // Si c'est aujourd'hui, afficher seulement l'heure
      return '$hour:$minute';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // Si c'est hier
      return 'Hier, $hour:$minute';
    } else if (now.difference(timestamp).inDays < 7) {
      // Si c'est dans la semaine, afficher le nom du jour
      final weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
      final weekday = weekdays[timestamp.weekday - 1];
      return '$weekday, $hour:$minute';
    } else {
      // Sinon afficher la date complète
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      return '$day/$month, $hour:$minute';
    }
  }
  
  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatPageBlocM>(context);
    _loadInitialData();
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  void _loadInitialData() {
    // Charger la liste des conversations
    _chatBloc.add(LoadConversations());
    
    // Si nous avons un ID de conversation, on charge ses messages
    if (widget.conversationId != null) {
      _chatBloc.add(LoadMessages(widget.conversationId!));
    }
    // Si nous avons des informations sur un participant mais pas d'ID de conversation,
    // on crée une nouvelle conversation
    else if (widget.participantId != null) {
      _chatBloc.add(CreateConversation(
        participantId: widget.participantId!,
        participantName: widget.participantName ?? 'Utilisateur',
        participantImage: widget.participantImage ?? 'assets/images/default_user.png',
        type: widget.type ?? ConversationType.prestataire,
      ));
    }
  }
  
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty && _selectedImage == null) return;
    
    final state = _chatBloc.state;
    if (state.status == ChatPageStatus.loaded && state.selectedConversation != null) {
      if (_selectedImage != null) {
        // Envoyer une image
        _chatBloc.add(SendMessage(
          conversationId: state.selectedConversation!.id,
          content: _selectedImage!.path,
          type: MessageType.image,
        ));
        setState(() => _selectedImage = null);
      } else {
        // Envoyer un message texte
        _chatBloc.add(SendMessage(
          conversationId: state.selectedConversation!.id,
          content: _messageController.text.trim(),
          type: MessageType.text,
        ));
        _messageController.clear();
      }
      
      // Faire défiler vers le bas après l'envoi
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      BlocBuilder<ChatPageBlocM, ChatPageStateM>(
                        builder: (context, state) {
                          final bool isMobile = MediaQuery.of(context).size.width < 600;
                          final bool showBackButton = isMobile && state.selectedConversation != null;
                          
                          return IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                            onPressed: () {
                              // Si on est sur mobile et une conversation est sélectionnée, retourner à la liste
                              if (showBackButton) {
                                // Simplement re-charger les conversations sans sélectionner aucune
                                context.read<ChatPageBlocM>().add(LoadConversations());
                              } else {
                                // Sinon, essayer de naviguer en arrière si possible
                                if (Navigator.of(context).canPop()) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 700),
                          builder: (context, value, child) => Opacity(
                            opacity: value,
                            child: child,
                          ),
                          child: BlocBuilder<ChatPageBlocM, ChatPageStateM>(
                            builder: (context, state) {
                              String title = 'DISCUSSIONS';
                              if (state.selectedConversation != null) {
                                // Utiliser le nom du participant comme titre
                                title = state.selectedConversation!.participantName;
                              
                              }
                              
                              return Center(
                                child: state.selectedConversation != null
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Badge selon type de conversation
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          color: _getConversationColor(state.selectedConversation!.type),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _getConversationLabel(state.selectedConversation!.type),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // Nom du participant
                                      Flexible(
                                        child: Text(
                                          title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Indicateur en ligne
                                      if (state.selectedConversation!.isOnline)
                                        Container(
                                          width: 12,
                                          height: 12,
                                          margin: const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.greenAccent.withOpacity(0.4),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  )
                                : Text(
                                    title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_isSearching)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          if (value.isNotEmpty) {
                            _chatBloc.add(SearchConversations(_searchQuery));
                          } else {
                            _chatBloc.add(LoadConversations());
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Rechercher une conversation...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          prefixIcon: Icon(Icons.search, color: Colors.white70),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<ChatPageBlocM, ChatPageStateM>(
        listener: (context, state) {
          // Gérer les erreurs
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!))
            );
          }
          
          // Faire défiler vers le bas après l'envoi ou la réception d'un message
          if (state.status == ChatPageStatus.loaded && 
              state.selectedConversation != null &&
              state.messagesByConversation.containsKey(state.selectedConversation!.id)) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          // Déterminer si on est sur mobile ou sur un écran plus grand
          final bool isMobile = MediaQuery.of(context).size.width < 600;
          final bool showConversationList = !isMobile || state.selectedConversation == null;
          final bool showConversation = !isMobile || state.selectedConversation != null;
          
          return Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Liste des conversations (affichée uniquement si nécessaire selon la responsivité)
                    if (showConversationList)
                      Flexible(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // En-tête de la liste des conversations
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                child: Text(
                                  'Conversations',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              // Liste des conversations
                              Expanded(
                                child: state.status == ChatPageStatus.loading
                                    ? const Center(child: CircularProgressIndicator())
                                    : state.conversations.isEmpty
                                        ? Center(child: Text('Aucune conversation'))
                                        : ListView.builder(
                                          itemCount: state.conversations.length,
                                          itemBuilder: (context, index) {
                                            final conversation = state.conversations[index];
                                            final bool isSelected = state.selectedConversation?.id == conversation.id;
                                            
                                            return InkWell(
                                              onTap: () {
                                                _chatBloc.add(SelectConversation(conversation));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                  color: isSelected ? Colors.green.withOpacity(0.1) : null,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    // Avatar
                                                    Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey.shade300,
                                                      image: conversation.participantImage.isNotEmpty
                                                          ? DecorationImage(
                                                              image: AssetImage(conversation.participantImage),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : null,
                                                    ),
                                                    child: conversation.participantImage.isEmpty
                                                        ? Center(
                                                            child: Text(
                                                              conversation.participantName[0].toUpperCase(),
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  // Contenu du message
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            conversation.participantName,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            conversation.lastMessage != null ? conversation.lastMessage!.content : '',
                                                            style: TextStyle(
                                                              color: Colors.grey.shade600,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Indicateurs (nouveau message, heure)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        // Format lastUpdated as a time string (e.g. '14:30')
                                                        "${conversation.lastUpdated.hour.toString().padLeft(2, '0')}:${conversation.lastUpdated.minute.toString().padLeft(2, '0')}",
                                                        style: TextStyle(
                                                          color: Colors.grey.shade600,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      if (conversation.unreadCount > 0)
                                                        Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            '${conversation.unreadCount}',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
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
                    // Zone de messages (affichée uniquement si une conversation est sélectionnée sur mobile)
                    if (showConversation)
                      Flexible(
                        flex: 7,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: state.selectedConversation == null
                              ? Center(child: Text('Sélectionnez une conversation'))
                              : AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: state.selectedConversation != null ? 1.0 : 0.0,
                                  child: Column(
                                    children: [
                                      // En-tête de la conversation
                                      Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Avatar
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300,
                                          image: state.selectedConversation!.participantImage.isNotEmpty
                                              ? DecorationImage(
                                                  image: AssetImage(state.selectedConversation!.participantImage),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: state.selectedConversation!.participantImage.isEmpty
                                            ? Center(
                                                child: Text(
                                                  state.selectedConversation!.participantName[0].toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      // Nom et statut
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.selectedConversation!.participantName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: state.selectedConversation!.isOnline ? Colors.green : Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                state.selectedConversation!.isOnline ? 'En ligne' : 'Hors ligne',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Liste des messages
                                Expanded(
                                  child: state.messagesByConversation.containsKey(state.selectedConversation!.id) &&
                                          state.messagesByConversation[state.selectedConversation!.id]!.isNotEmpty
                                      ? ListView.builder(
                                          controller: _scrollController,
                                          padding: const EdgeInsets.all(16.0),
                                          itemCount: state.messagesByConversation[state.selectedConversation!.id]!.length,
                                          itemBuilder: (context, index) {
                                            final message = state.messagesByConversation[state.selectedConversation!.id]![index];
                                            final bool isMe = message.senderId == 'currentUser'; // À adapter selon votre logique d'ID utilisateur
                                            
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 12.0),
                                              child: Row(
                                                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  // Avatar du participant (uniquement pour les messages reçus)
                                                  if (!isMe && index == 0 || 
                                                      !isMe && index > 0 && 
                                                      state.messagesByConversation[state.selectedConversation!.id]![index-1].senderId == 'currentUser')
                                                    Container(
                                                      width: 28,
                                                      height: 28,
                                                      margin: const EdgeInsets.only(right: 8.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey.shade300,
                                                        image: state.selectedConversation!.participantImage.isNotEmpty
                                                            ? DecorationImage(
                                                                image: AssetImage(state.selectedConversation!.participantImage),
                                                                fit: BoxFit.cover,
                                                              )
                                                            : null,
                                                        border: Border.all(color: Colors.white, width: 1.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: state.selectedConversation!.participantImage.isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                state.selectedConversation!.participantName[0].toUpperCase(),
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            )
                                                          : null,
                                                    )
                                                  else if (!isMe)
                                                    SizedBox(width: 36),  // Espacement pour aligner les messages
                                                    
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                                                    decoration: BoxDecoration(
                                                      color: isMe ? Color(0xFFE6F8E6) : Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(18.0),
                                                        topRight: Radius.circular(18.0),
                                                        bottomLeft: isMe ? Radius.circular(18.0) : Radius.circular(4.0),
                                                        bottomRight: isMe ? Radius.circular(4.0) : Radius.circular(18.0),
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.05),
                                                          blurRadius: 3,
                                                          offset: Offset(0, 1),
                                                        ),
                                                      ],
                                                      border: Border.all(color: isMe ? Colors.green.shade100 : Colors.grey.shade200, width: 1),
                                                    ),
                                                    constraints: BoxConstraints(
                                                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          message.content,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: isMe ? Colors.black87 : Colors.black87,
                                                            height: 1.3,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              _formatMessageTime(message.timestamp),
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors.grey.shade600,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            if (isMe) ...
                                                            [
                                                              const SizedBox(width: 4),
                                                              Icon(
                                                                message.status == MessageStatus.seen
                                                                    ? Icons.done_all
                                                                    : message.status == MessageStatus.delivered
                                                                        ? Icons.done_all
                                                                        : message.status == MessageStatus.sent
                                                                            ? Icons.done
                                                                            : Icons.access_time,
                                                                size: 14,
                                                                color: message.status == MessageStatus.seen
                                                                    ? Colors.blue
                                                                    : Colors.grey,
                                                              ),
                                                            ],
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Center(child: Text('Aucun message')),
                                ),
                                // Zone de saisie
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Bouton pour ajouter une image
                                      IconButton(
                                        icon: Icon(Icons.image),
                                        onPressed: () {
                                          // Implémenter la sélection d'images
                                        },
                                      ),
                                      // Champ de texte
                                      Expanded(
                                        child: TextField(
                                          controller: _messageController,
                                          focusNode: _focusNode,
                                          decoration: InputDecoration(
                                            hintText: 'Tapez un message...',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                          ),
                                        ),
                                      ),
                                      // Bouton d'envoi
                                      IconButton(
                                        icon: Icon(Icons.send, color: Colors.green),
                                        onPressed: _sendMessage,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
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