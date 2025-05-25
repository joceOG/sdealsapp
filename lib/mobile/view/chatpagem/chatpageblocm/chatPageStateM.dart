
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';


class ChatPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const ChatPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory ChatPageStateM.initial() {
    return const ChatPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  ChatPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return ChatPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









