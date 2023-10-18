import 'question_model.dart';

//Ta bort?
class Quiz {
  final String title;
  final String description;
  final List<Question> questions; // List of questions

  Quiz({
    required this.title,
    required this.description,
    required this.questions,
  });
}

// Folder class
class CreateFolder {
  final String title;

  CreateFolder({required this.title});
}

class FolderContents {
  final String itemName;

  FolderContents(this.itemName);
}

class Folder {
  final String title;
  final String description;
  final List<Quiz> quizzes;

  Folder(
      {required this.title, required this.description, required this.quizzes});
}
