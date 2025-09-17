import 'package:equatable/equatable.dart';
import '../../../data/models/conversation_model.dart';
import '../../../data/models/message_model.dart';

abstract class ChatPageEventM extends Equatable {
  const ChatPageEventM();

  @override
  List<Object?> get props => [];
}

// Événement pour charger toutes les conversations
class LoadConversations extends ChatPageEventM {
  const LoadConversations();
}

// Événement pour sélectionner une conversation
class SelectConversation extends ChatPageEventM {
  final ConversationModel conversation;

  const SelectConversation(this.conversation);

  @override
  List<Object> get props => [conversation];
}

// Événement pour charger les messages d'une conversation
class LoadMessages extends ChatPageEventM {
  final String conversationId;
  final int? limit;
  final int? offset;

  const LoadMessages(this.conversationId, {this.limit, this.offset});

  @override
  List<Object?> get props => [conversationId, limit, offset];
}

// Événement pour envoyer un message
class SendMessage extends ChatPageEventM {
  final String conversationId;
  final String content;
  final MessageType type;

  const SendMessage({
    required this.conversationId,
    required this.content,
    this.type = MessageType.text,
  });

  @override
  List<Object> get props => [conversationId, content, type];
}

// Événement pour marquer un message comme lu
class MarkMessageAsRead extends ChatPageEventM {
  final String conversationId;
  final String messageId;

  const MarkMessageAsRead({
    required this.conversationId,
    required this.messageId,
  });

  @override
  List<Object> get props => [conversationId, messageId];
}

// Événement pour marquer une conversation comme lue
class MarkConversationAsRead extends ChatPageEventM {
  final String conversationId;

  const MarkConversationAsRead(this.conversationId);

  @override
  List<Object> get props => [conversationId];
}

// Événement pour créer une nouvelle conversation
class CreateConversation extends ChatPageEventM {
  final String participantId;
  final String participantName;
  final String participantImage;
  final ConversationType type;

  const CreateConversation({
    required this.participantId,
    required this.participantName,
    required this.participantImage,
    required this.type,
  });

  @override
  List<Object> get props => [participantId, participantName, participantImage, type];
}

// Événement pour la recherche de conversations
class SearchConversations extends ChatPageEventM {
  final String query;

  const SearchConversations(this.query);

  @override
  List<Object> get props => [query];
}

// Classe pour la rétrocompatibilité avec le code existant
class LoadCategorieDataM extends ChatPageEventM {}

