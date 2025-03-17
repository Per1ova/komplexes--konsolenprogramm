import 'dart:io';

Map<int, DateTime> activeCodes = {
  100101: DateTime(2024, 3, 10),
  100102: DateTime(2025, 5, 12),
  100103: DateTime(2025, 7, 15),
  100104: DateTime(2025, 9, 18),
};

Map<String, List<String>> categories = {
  "Movies": ["Movie 1", "Movie 2", "Movie 3"],
  "Series": ["Serie 1", "Serie 2", "Serie 3"],
  "Live Stream": ["Channel 1", "Channel 2", "Channel 3"],
};

List<String> favoriteList = [];

void main() {
  while (true) {
    int? enteredCode = getActiveCode();
    if (enteredCode == null) continue;

    if (!validateCode(enteredCode)) continue;

    showCategories();
    chooseContent();
  }
}

/// دالة لإدخال الكود والتحقق منه
int? getActiveCode() {
  print("\nPlease enter your Active Code:");
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print("Invalid input! Please enter a valid code.");
    return null;
  }

  int? enteredCode = int.tryParse(input);
  if (enteredCode == null) {
    print("Invalid input! Please enter numbers only.");
    return null;
  }

  return enteredCode;
}

/// check if code valid
bool validateCode(int enteredCode) {
  DateTime? expiryDate = activeCodes[enteredCode];
  DateTime currentDate = DateTime.now();

  if (expiryDate == null) {
    print("Invalid code entered! ❌");
    return false;
  }

  if (expiryDate.isBefore(currentDate)) {
    print(
      "Your Active Code has expired ⏱️. Expiry Date was: ${expiryDate.toLocal()}",
    );
    print("Please renew your subscription ❌");
    return false;
  }

  int remainingDays = expiryDate.difference(currentDate).inDays;
  print(
    "✅ Login Successful! Your account is valid until ${expiryDate.toLocal()} ($remainingDays days remaining).",
  );
  return true;
}

/// Display categories
void showCategories() {
  print("\nAvailable Categories:");
  categories.forEach((category, content) {
    print("- $category");
  });
}

/// Display content & add favourite
void chooseContent() {
  print("\nEnter category name to explore content:");
  String? categoryInput = stdin.readLineSync();

  if (categoryInput == null || !categories.containsKey(categoryInput)) {
    print("Invalid category! Please try again.");
    return;
  }

  print("\nAvailable Content in $categoryInput:");
  List<String> contentList = categories[categoryInput]!;

  for (int i = 0; i < contentList.length; i++) {
    print("${i + 1}. ${contentList[i]}");
  }

  print("\nEnter content number to add to favorites:");
  String? contentInput = stdin.readLineSync();
  int? contentIndex = int.tryParse(contentInput ?? "");

  if (contentIndex == null ||
      contentIndex < 1 ||
      contentIndex > contentList.length) {
    print("Invalid selection! Returning to main menu.");
    return;
  }

  String selectedContent = contentList[contentIndex - 1];
  favoriteList.add(selectedContent);
  print("$selectedContent added to favorites ❤️");

  print("\nYour Favorite List: $favoriteList");
}
