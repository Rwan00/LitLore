import 'package:equatable/equatable.dart';

import 'package:litlore/features/home/data/models/book_shelves_model/book_shelves_model/item.dart';

enum BookShelvesStatus {
  initial,
  loading,
  success,
  failure,
 
}

class BookShelvesState extends Equatable {
  final BookShelvesStatus status;
  final String? errorMessage;
  final String? successMessage;

  final List<ShelfItem>? shelves;
  

  const BookShelvesState({
    this.status = BookShelvesStatus.initial,
    this.errorMessage,
this.successMessage,
    this.shelves,
    
  });

  factory BookShelvesState.initial() {
    return const BookShelvesState(status: BookShelvesStatus.initial);
  }

  BookShelvesState copyWith({
    BookShelvesStatus? status,
    String? errorMessage,
    String? successMessage,

    List<ShelfItem>? shelves,
   
  }) {
    return BookShelvesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,

      shelves: shelves ?? this.shelves,
     
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
successMessage,
    shelves,
   
  ];
}
