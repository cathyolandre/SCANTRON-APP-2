class Student {
  final String id;        // Unique ID for the student (could be their QR code ID)
  final String name;      // Student's name
  final int year;         // Year level of the student (1 or 2)
  int remainingSheets;    // Number of sheets the student can still order

  // Constructor
  Student({
    required this.id,
    required this.name,
    required this.year,
    required this.remainingSheets,
  });

  // Factory constructor to create a Student from a database or API response
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      remainingSheets: json['remainingSheets'],
    );
  }

  // Convert the Student object back to a map (for updating the database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'remainingSheets': remainingSheets,
    };
  }

  // Helper method to reset remaining sheets based on year level
  void resetRemainingSheets() {
    if (year == 1) {
      remainingSheets = 30;
    } else if (year == 2) {
      remainingSheets = 20;
    }
  }
}
