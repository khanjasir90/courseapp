abstract class MockCourseSource {
  Future<Map<String, dynamic>> getAllCourses();
  Future<Map<String, dynamic>> searchCourses(String query);
}

class MockCourseSourceImpl implements MockCourseSource {
  @override
  Future<Map<String, dynamic>> getAllCourses() async {
    return {
      "courses": [
        {"id": 1, "name": "Flutter Basics", "duration": "4 weeks"},
        {"id": 2, "name": "Advanced Dart", "duration": "6 weeks"},
        {"id": 3, "name": "Kotlin for Android", "duration": "5 weeks"},
        {"id": 4, "name": "Swift for iOS", "duration": "7 weeks"},
        {"id": 5, "name": "React Native", "duration": "8 weeks"},
        {"id": 6, "name": "Python for Data Science", "duration": "10 weeks"},
        {"id": 7, "name": "Java Basics", "duration": "6 weeks"},
        {"id": 8, "name": "C++ Algorithms", "duration": "4 weeks"},
        {"id": 9, "name": "Ruby on Rails", "duration": "6 weeks"},
        {"id": 10, "name": "Node.js Fundamentals", "duration": "5 weeks"},
        {"id": 11, "name": "Express.js Advanced", "duration": "7 weeks"},
        {"id": 12, "name": "MongoDB Essentials", "duration": "3 weeks"},
        {"id": 13, "name": "AWS Cloud Basics", "duration": "6 weeks"},
        {"id": 14, "name": "Azure Cloud Development", "duration": "8 weeks"},
        {
          "id": 15,
          "name": "Machine Learning with Python",
          "duration": "12 weeks"
        },
        {"id": 16, "name": "Deep Learning Basics", "duration": "10 weeks"},
        {"id": 17, "name": "DevOps Fundamentals", "duration": "5 weeks"},
        {"id": 18, "name": "Docker and Kubernetes", "duration": "8 weeks"},
        {"id": 19, "name": "Git Version Control", "duration": "2 weeks"},
        {"id": 20, "name": "GraphQL Basics", "duration": "4 weeks"},
        {"id": 21, "name": "TypeScript Essentials", "duration": "5 weeks"},
        {"id": 22, "name": "Angular for Beginners", "duration": "6 weeks"},
        {"id": 23, "name": "Vue.js Basics", "duration": "4 weeks"},
        {"id": 24, "name": "Next.js Fullstack", "duration": "8 weeks"},
        {"id": 25, "name": "Golang Fundamentals", "duration": "6 weeks"},
        {"id": 26, "name": "Blockchain Development", "duration": "9 weeks"},
        {"id": 27, "name": "Solidity Programming", "duration": "7 weeks"},
        {"id": 28, "name": "Flutter Advanced Widgets", "duration": "5 weeks"},
        {"id": 29, "name": "React State Management", "duration": "6 weeks"},
        {"id": 30, "name": "Vuex for Vue.js", "duration": "5 weeks"},
        {"id": 31, "name": "Redux Advanced", "duration": "7 weeks"},
        {"id": 32, "name": "Svelte for Web Development", "duration": "4 weeks"},
        {"id": 33, "name": "CSS Grid and Flexbox", "duration": "3 weeks"},
        {"id": 34, "name": "HTML5 for Beginners", "duration": "2 weeks"},
        {"id": 35, "name": "JavaScript ES6 and Beyond", "duration": "5 weeks"},
        {"id": 36, "name": "PHP and Laravel", "duration": "8 weeks"},
        {"id": 37, "name": "PostgreSQL Advanced", "duration": "6 weeks"},
        {"id": 38, "name": "MySQL Essentials", "duration": "4 weeks"},
        {"id": 39, "name": "Cybersecurity Basics", "duration": "6 weeks"},
        {"id": 40, "name": "Ethical Hacking", "duration": "10 weeks"},
        {"id": 41, "name": "Introduction to AI", "duration": "7 weeks"},
        {"id": 42, "name": "UI/UX Design Principles", "duration": "5 weeks"},
        {"id": 43, "name": "Figma for Prototypes", "duration": "3 weeks"},
        {"id": 44, "name": "Adobe XD Essentials", "duration": "4 weeks"},
        {"id": 45, "name": "Microservices Architecture", "duration": "6 weeks"},
        {"id": 46, "name": "Spring Boot for Java", "duration": "8 weeks"},
        {"id": 47, "name": "Android Jetpack Compose", "duration": "7 weeks"},
        {"id": 48, "name": "iOS SwiftUI Basics", "duration": "6 weeks"},
        {
          "id": 49,
          "name": "Data Structures and Algorithms",
          "duration": "12 weeks"
        },
        {"id": 50, "name": "Operating System Concepts", "duration": "9 weeks"}
      ],
      "total": 50
    };
  }

  @override
  Future<Map<String, dynamic>> searchCourses(String query) async {
    return {
      "courses": [
        {"id": 1, "name": "Flutter Basics", "duration": "4 weeks"},
        {"id": 2, "name": "Advanced Dart", "duration": "6 weeks"},
        {"id": 3, "name": "Kotlin for Android", "duration": "5 weeks"},
        {"id": 4, "name": "Swift for iOS", "duration": "7 weeks"},
        {"id": 5, "name": "React Native", "duration": "8 weeks"},
        {"id": 6, "name": "Python for Data Science", "duration": "10 weeks"},
        {"id": 7, "name": "Java Basics", "duration": "6 weeks"},
        {"id": 8, "name": "C++ Algorithms", "duration": "4 weeks"},
        {"id": 9, "name": "Ruby on Rails", "duration": "6 weeks"},
        {"id": 10, "name": "Node.js Fundamentals", "duration": "5 weeks"},
        {"id": 11, "name": "Express.js Advanced", "duration": "7 weeks"},
        {"id": 12, "name": "MongoDB Essentials", "duration": "3 weeks"},
        {"id": 13, "name": "AWS Cloud Basics", "duration": "6 weeks"},
        {"id": 14, "name": "Azure Cloud Development", "duration": "8 weeks"},
        {
          "id": 15,
          "name": "Machine Learning with Python",
          "duration": "12 weeks"
        },
        {"id": 16, "name": "Deep Learning Basics", "duration": "10 weeks"},
        {"id": 17, "name": "DevOps Fundamentals", "duration": "5 weeks"},
        {"id": 18, "name": "Docker and Kubernetes", "duration": "8 weeks"},
        {"id": 19, "name": "Git Version Control", "duration": "2 weeks"},
        {"id": 20, "name": "GraphQL Basics", "duration": "4 weeks"},
        {"id": 21, "name": "TypeScript Essentials", "duration": "5 weeks"},
        {"id": 22, "name": "Angular for Beginners", "duration": "6 weeks"},
        {"id": 23, "name": "Vue.js Basics", "duration": "4 weeks"},
        {"id": 24, "name": "Next.js Fullstack", "duration": "8 weeks"},
        {"id": 25, "name": "Golang Fundamentals", "duration": "6 weeks"},
        {"id": 26, "name": "Blockchain Development", "duration": "9 weeks"},
        {"id": 27, "name": "Solidity Programming", "duration": "7 weeks"},
        {"id": 28, "name": "Flutter Advanced Widgets", "duration": "5 weeks"},
        {"id": 29, "name": "React State Management", "duration": "6 weeks"},
        {"id": 30, "name": "Vuex for Vue.js", "duration": "5 weeks"},
        {"id": 31, "name": "Redux Advanced", "duration": "7 weeks"},
        {"id": 32, "name": "Svelte for Web Development", "duration": "4 weeks"},
        {"id": 33, "name": "CSS Grid and Flexbox", "duration": "3 weeks"},
        {"id": 34, "name": "HTML5 for Beginners", "duration": "2 weeks"},
        {"id": 35, "name": "JavaScript ES6 and Beyond", "duration": "5 weeks"},
        {"id": 36, "name": "PHP and Laravel", "duration": "8 weeks"},
        {"id": 37, "name": "PostgreSQL Advanced", "duration": "6 weeks"},
        {"id": 38, "name": "MySQL Essentials", "duration": "4 weeks"},
        {"id": 39, "name": "Cybersecurity Basics", "duration": "6 weeks"},
        {"id": 40, "name": "Ethical Hacking", "duration": "10 weeks"},
        {"id": 41, "name": "Introduction to AI", "duration": "7 weeks"},
        {"id": 42, "name": "UI/UX Design Principles", "duration": "5 weeks"},
        {"id": 43, "name": "Figma for Prototypes", "duration": "3 weeks"},
        {"id": 44, "name": "Adobe XD Essentials", "duration": "4 weeks"},
        {"id": 45, "name": "Microservices Architecture", "duration": "6 weeks"},
        {"id": 46, "name": "Spring Boot for Java", "duration": "8 weeks"},
        {"id": 47, "name": "Android Jetpack Compose", "duration": "7 weeks"},
        {"id": 48, "name": "iOS SwiftUI Basics", "duration": "6 weeks"},
        {
          "id": 49,
          "name": "Data Structures and Algorithms",
          "duration": "12 weeks"
        },
        {"id": 50, "name": "Operating System Concepts", "duration": "9 weeks"}
      ],
      "total": 50
    };
  }
}
