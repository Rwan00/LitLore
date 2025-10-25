class Urls {
  static const String baseUrl = "https://www.googleapis.com/books/v1/";

  // 🔍 Search for books
  // Example: volumes?q=flutter
  static String searchBooks(String query, {String? filter, String? orderBy, String? contentType,}) {
    final buffer = StringBuffer("volumes?q=$query");
    if (filter != null && filter != "all") buffer.write("&filter=$filter");
    if (orderBy != null) buffer.write("&orderBy=$orderBy");
    if (contentType != null) buffer.write("&contentType=$contentType");
   
    return buffer.toString();
  }

  // 🎭 Discover books by subject (category)
  // Example: volumes?q=subject:Drama
  static String discoverBooksBySubject(String subject) => "volumes?q=subject:$subject";

  // 🆕 Get newest books
  // Example: volumes?q=*&orderBy=newest
  static const String newestBooks = "volumes?q=newest&orderBy=newest";

  // 📚 Get a specific volume by ID
  // Example: volumes/{volumeId}
  static String bookDetails(String volumeId) => "volumes/$volumeId";

  // ❤️ Get books similar to a category
  // Example: volumes?q=Science+subject:&orderBy=relevance
  static String similarBooks(String category) => "volumes?q=$category+subject:&orderBy=relevance";

  // 👤 Get books by author
  // Example: volumes?q=inauthor:J.K. Rowling
  static String booksByAuthor(String author) => "volumes?q=inauthor:$author";

  // 🏢 Get books by publisher
  // Example: volumes?q=inpublisher:Penguin
  static String booksByPublisher(String publisher) => "volumes?q=inpublisher:$publisher";

  // 🔢 Get books by ISBN
  // Example: volumes?q=isbn:9781451648546
  static String booksByISBN(String isbn) => "volumes?q=isbn:$isbn";

  // 🔠 Get books by title
  // Example: volumes?q=intitle:Harry Potter
  static String booksByTitle(String title) => "volumes?q=intitle:$title";

  // 🧾 Get MyLibrary Bookshelves (for authenticated users)
  // Example: mylibrary/bookshelves
  static const String myLibraryBookshelves = "mylibrary/bookshelves";

  // 📚 Get Books in a specific bookshelf
  // Example: mylibrary/bookshelves/{shelfId}/volumes
  static String myLibraryBooks(String shelfId) => "mylibrary/bookshelves/$shelfId/volumes";

  // 📘 Get Volume annotations (requires OAuth)
  // Example: mylibrary/annotations
  static const String myLibraryAnnotations = "mylibrary/annotations";

  // ⭐ Get user info (authenticated)
  static const String userInfo = "users/me";

  // 📈 Recommended or related volumes (sometimes used with API key)
  // Example: volumes/recommended?volumeId={id}
  static String recommendedBooks(String volumeId) => "volumes/recommended?volumeId=$volumeId";
}
