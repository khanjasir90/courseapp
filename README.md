# Flutter App with Provider State Management

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Documentation](#documentation)
  - [State Management (Provider)](#state-management-provider)
  - [Lazy Loading](#lazy-loading)
  - [Key Performance Optimizations](#key-performance-optimizations)
  - [Comparison: Provider vs BLoC vs Riverpod](#comparison-provider-vs-bloc-vs-riverpod)
- [Edge Case Handling](#edge-case-handling)
- [Screen Recording](#screen-recording)

---

## Introduction
This is a Flutter app that showcases:
- State management using the Provider package.
- Lazy loading for efficient data fetching and display.
- Unit testing for search functionality.
- Edge case handling for API timeouts and empty data.


## Using Abstraction for Scalable and Maintainable Search Functionality

In this implementation, we have used **abstraction** and followed **best practices** to ensure that the code remains **scalable** and **maintainable**, especially when adding new search functionality in the future.

### 1. **Abstraction with an Abstract Class**
The `Search` class is an abstract class that defines the contract for the search functionality. This provides the flexibility to introduce new search strategies (e.g., fuzzy search, Elasticsearch) in the future by simply extending this abstract class.

### 2. **Decoupling Search Logic from UI**
By abstracting the search logic into the `SearchImpl` class, we keep the UI code (e.g., `CourseSearchView`) independent of the underlying search implementation. This allows us to change the search logic without modifying the UI.

### 3. **Ease of Extension**
Adding new search types is easy. You can create new classes that extend the `Search` class and implement the `searchCourses` method, following the same contract. This design follows the **Open/Closed Principle**, allowing for extension without modification.

### 4. **Polymorphism**
The `SearchImpl` class overrides the `searchCourses` method, allowing polymorphism. This means we can swap out search algorithms easily while keeping the interface consistent.

### 5. **Maintainability & Testability**
By separating the search logic into an abstract class, the code is easier to maintain and test. New search strategies can be added without affecting existing code, and the code is easily testable with mocks or stubs.

### Conclusion
This abstraction ensures that the code remains **flexible**, **scalable**, and **easy to maintain** in the future, especially when adding new search features or changing the underlying search implementation.

Implementation

```bash

import '../data/model/course_model.dart';

abstract class Search {

  CourseResponse searchCourses(CourseResponse courses, String query);
}

class SearchImpl extends Search {

  @override
  CourseResponse searchCourses(CourseResponse courses, String query) {
    final List<Course> searchResults = [];

    query = query.trim();

    if(query.isEmpty) {
      return CourseResponse(courses: [], total: 0);
    }

    for(final course in courses.courses) {
      if(course.name.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(course);
      }
    }

    return CourseResponse(courses: searchResults, total: searchResults.length);
  }
}

```

## Features
- Functional and visually appealing UI.
- Lazy-loaded data for seamless performance.
```bash
void _fetchNextPage() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final provider = context.read<CourseProvider>();
      provider.getAllCourses((provider.courses?.courses.length ?? 10)+ 10);
    }
  }

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: widget.courses.courses.length,
            itemBuilder: (context, index) {
              final Course course = widget.courses.courses[index];
              return CourseCard(
                course: course,
                onCourseSelected: _onCourseSelected,
                onCourseUnselected: _onCourseUnSelected,
                isSelectionEnabled: widget.isSelectionEnabled,
                provider: context.read<CourseProvider>(),
              );
            },
          ),
        ),
      ],
    );
  }
```
- State management using Provider.
```bash
 ChangeNotifierProvider(
          create: (context) => CourseProvider(
            courseRepository: CourseRepositoryImpl(
              courseDataSource: MockCourseSourceImpl(),
              searchUtil: SearchImpl(),
            ),
          ),
        ),
```

- Robust handling of edge cases like API failures and empty datasets.
```bash
@override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CourseProvider>(
        builder: (context, value, child) {
          if (value.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.status.isFailure) {
            return const Center(child: Text('Failed to load courses'));
          } else if (value.status.isSuccess &&
              (value.filteredCourses?.courses.isEmpty ?? true)) {
            return const Center(child: Text('Please search for a course'));
          } else if (value.status.isSuccess) {
            return LazyList(
              courses: value.filteredCourses!,
              isSelectionEnabled: value.isSelectionEnabled,
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
```

- Animation while navigating between Pages.

```bash
class PageRouteUtil {
  static PageRouteBuilder createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page; 
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        const begin = Offset(1.0, 0.0); 
        const end = Offset.zero; 
        const curve = Curves.easeInOut; 

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500), 
    );
  }
}
```

---

## Installation

### Prerequisites
1. Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
2. Git: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/khanjasir90/courseapp.git
   cd courseapp
   ```
2. Install Dependencies:
    ```bash
    flutter pub get
    ```
3. Run the App
    ```bash
    flutter run
    ```

## Testing
1. Run unit test for search functionality
    ``` bash
    flutter test test/search_impl_test.dart
    ```
2. Examples of Test Written for Search Feature.
    ```bash
     test('Empty search query returns empty result', () {
      // Arrange
      const query = '';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isEmpty);
      expect(result.total, 0);
    });

    test('Performance with large number of courses', () {
      // Arrange
      const query = '2';
      final courses = CourseResponse(courses: List.generate(1000, (index) => Course(
          id: index,
          name: 'Course $index',
          duration: 'Duration $index',
      )), total: 1000);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isNotEmpty);
      expect(result.total, isNonZero);
    });

      test('Search query with non-alphabetic characters', () {
      // Arrange
      const query = 'AI 2021';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'AI 2021', duration: '4 weeks'),
        Course(id: 2, name: 'AI 2020', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'AI 2021');
      expect(result.total, 1);
    });
    ```
## Full Test File

To see the full test file, you can view it here:

[search_impl_test.dart](test/search_impl_test.dart)


## Documentation

### How you used Provider for State Management?

## Introduction to Provider

In the CourseApp, **Provider** is used to manage the state across the application. It provides a simple and efficient way to share state between different widgets without manually passing data down the widget tree. Provider listens for changes in the state and rebuilds the widgets accordingly.

## How Provider is Used

### 1. **CourseProvider for State Management**

The `CourseProvider` class is a `ChangeNotifier` that manages the state related to courses. It stores and updates the list of courses, filtered courses based on the search query, and the selected courses. 

```dart
class CourseProvider extends ChangeNotifier {
  CourseResponse? _courses;
  CourseResponse? _filteredCourses;
  bool _isSelectionEnabled = false;
  List<Course> _selectedCourseList = [];

  // Getters and Setters
  CourseResponse? get courses => _courses;
  CourseResponse? get filteredCourses => _filteredCourses;
  bool get isSelectionEnabled => _isSelectionEnabled;
  List<Course> get selectedCourseList => _selectedCourseList;

  // Method to update courses
  void setCourses(CourseResponse courses) {
    _courses = courses;
    notifyListeners();
  }

  // Method to enable/disable selection
  void toggleSelection() {
    _isSelectionEnabled = !_isSelectionEnabled;
    notifyListeners();
  }

  // Method to search courses based on query
  void searchCourses(String query) {
    // logic to filter courses based on search query
    notifyListeners();
  }

  // Method to add course to selection list
  void addCourse(Course course) {
    _selectedCourseList.add(course);
    notifyListeners();
  }

  // Method to remove course from selection list
  void removeCourse(Course course) {
    _selectedCourseList.remove(course);
    notifyListeners();
  }
}

```
### Provider Setup in the Widget Tree
- The CourseProvider is provided at the root of the widget tree, allowing any descendant widget to access the provider and listen for state changes. The ChangeNotifierProvider widget is used to set up the provider.

```bash
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(),
      child: const MyApp(),
    ),
  );
}
```

### Using Provider in Widgets
- In the widgets, the Consumer widget is used to listen for changes in the CourseProvider and rebuild UI elements when the state changes. For example, in the CourseSearchView, we use Consumer<CourseProvider> to react to changes in the list of courses, search query, and selected courses.

```bash
class CourseListView extends StatelessWidget {
  const CourseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CourseProvider>(
        builder: (context, value, child) {
          if (value.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.status.isFailure) {
            return const Center(child: Text('Failed to load courses'));
          } else if (value.status.isSuccess && (value.filteredCourses?.courses.isEmpty ?? true)) {
            return const Center(child: Text('Please search for a course'));
          } else if (value.status.isSuccess) {
            return LazyList(
              courses: value.filteredCourses!,
              isSelectionEnabled: value.isSelectionEnabled,
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
```

### Benefits of Using Provider
Efficiency: Provider ensures efficient updates and avoids unnecessary widget rebuilds. Only the widgets that are listening to the ChangeNotifier will rebuild when the state changes.

Decoupling: The state is managed separately in the CourseProvider, allowing for better separation of concerns between the UI and business logic.

Scalability: Provider is a lightweight and scalable solution that grows well with the application, making it easy to manage the state for both small and large apps.

### Lazy Loading Implementation
- We implemented the Lazy Loading using following steps.

#### ScrollController Initialization
1. A ScrollController is used to monitor the scroll position of the ListView.
``` bash
 ScrollController _scrollController = ScrollController();
```

#### Adding a Listener
1. The listener _fetchNextPage is added to the ScrollController to detect when the user scrolls to the end.
``` bash
 _scrollController.addListener(_fetchNextPage);
```

#### Fetching More Data
1. When the user scrolls to the end, _fetchNextPage is triggered to fetch additional data using the CourseProvider.
``` bash
 void _fetchNextPage() {
  if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    final provider = context.read<CourseProvider>();
    provider.getAllCourses((provider.courses?.courses.length ?? 10) + 10);
  }
}
```

#### Dynamic Rendering
1. ListView.builder dynamically renders the list items, ensuring only the visible items are built.
``` bash
 ListView.builder(
  controller: _scrollController,
  itemCount: widget.courses.courses.length,
  itemBuilder: (context, index) {
    final Course course = widget.courses.courses[index];
    return CourseCard(
      course: course,
      onCourseSelected: _onCourseSelected,
      onCourseUnselected: _onCourseUnSelected,
      isSelectionEnabled: widget.isSelectionEnabled,
      provider: context.read<CourseProvider>(),
    );
  },
);
```

#### 
1. ListView.builder dynamically renders the list items, ensuring only the visible items are built.
``` bash
 ListView.builder(
  controller: _scrollController,
  itemCount: widget.courses.courses.length,
  itemBuilder: (context, index) {
    final Course course = widget.courses.courses[index];
    return CourseCard(
      course: course,
      onCourseSelected: _onCourseSelected,
      onCourseUnselected: _onCourseUnSelected,
      isSelectionEnabled: widget.isSelectionEnabled,
      provider: context.read<CourseProvider>(),
    );
  },
);
```

#### Cleaning Up

1.The ScrollController is disposed of to avoid memory leaks.

``` bash
@override
void dispose() {
  _scrollController.removeListener(_fetchNextPage);
  _scrollController.dispose();
  super.dispose();
}

```
    

### Key Performance Optimizations

#### Key Optimizations in LazyList Implementation

##### 1. **Efficient Resource Management**
- **ScrollController Initialization & Cleanup**:  
  The `ScrollController` is properly initialized in `initState` and disposed of in `dispose`. This avoids memory leaks and ensures no unnecessary event listeners linger after the widget is removed.

  ```dart
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_fetchNextPage);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_fetchNextPage);
    _scrollController.dispose();
    super.dispose();
  }
##### 2. **Efficient UI Rendering**

- **Using `ListView.builder`**:  
  The `ListView.builder` widget is used to efficiently render only the visible items in the list. This optimization reduces memory usage and enhances performance, especially when handling large datasets.

```dart
ListView.builder(
  controller: _scrollController,
  itemCount: widget.courses.courses.length,
  itemBuilder: (context, index) {
    final Course course = widget.courses.courses[index];
    return CourseCard(
      course: course,
      onCourseSelected: _onCourseSelected,
      onCourseUnselected: _onCourseUnSelected,
      isSelectionEnabled: widget.isSelectionEnabled,
      provider: context.read<CourseProvider>(),
    );
  },
);

```

##### 3. **Lazy Loading Implementation**

- **Scroll Controller**:  
  A `ScrollController` is used to track the scroll position of the list and trigger lazy loading when the user reaches the bottom of the list.

```dart
ScrollController _scrollController = ScrollController();

@override
void initState() {
  super.initState();
  _scrollController.addListener(_fetchNextPage);
}

void _fetchNextPage() {
  if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    final provider = context.read<CourseProvider>();
    provider.getAllCourses((provider.courses?.courses.length ?? 10) + 10);
  }
}

@override
void dispose() {
  _scrollController.removeListener(_fetchNextPage);
  _scrollController.dispose();
  super.dispose();
}

```

##### Optimization 4: Post-Frame Callback for Initial API Call

###### Explanation:
- The `WidgetsBinding.instance.addPostFrameCallback` is used in the `initState` method to perform an initial API call **after the widget tree has been built**.
- This approach ensures that the widget's state is fully initialized before triggering side effects like fetching data, preventing unnecessary widget rebuilds during the initial load.

---

### Code Implementation:
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CourseProvider>().searchCourses('');
  });
}

```

##### Optimization: Use of `const` for Widgets

###### Why Use `const` in Flutter?
Marking widgets as `const` brings multiple advantages:
1. **Improves Performance**: Prevents unnecessary rebuilds by making widgets immutable.
2. **Saves Memory**: Ensures widgets are stored only once in memory and reused across the widget tree.
3. **Compile-Time Error Detection**: Avoids runtime errors by catching mutability issues early.

Using const ensures that Flutter optimizes widget creation and rendering, resulting in smoother animations, lower memory usage, and faster rebuilds for your app.

---

### Example Code:

#### With `const`:
```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Courses'),
        leading: IconButton(
          onPressed: () => _navigateToCoursePage(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const SearchTextField(),
            const CourseListView(),
          ],
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }

```

### Difference between BLoC, Provider and Riverpod

## 1. **State Management Approach**
- **BLoC (Business Logic Component)**:
  - Uses streams and sinks for managing state.
  - Provides a clear separation of concerns by isolating the business logic from UI.
  - Works well for complex state management but can feel verbose due to the need to define events and states.
  
- **Provider**:
  - A simpler and more intuitive approach to state management.
  - Uses a `ChangeNotifier` model to manage and notify listeners of state changes.
  - Best suited for small to medium-sized applications with straightforward state needs.

- **Riverpod**:
  - Built by the same creator as Provider but offers more flexibility and power.
  - Avoids the limitations of `InheritedWidget` and uses `Provider`'s concepts in a more modular and testable way.
  - Supports **auto-disposal** of state, **better error handling**, and **higher composability** than Provider.

## 2. **Flexibility and Testability**
- **BLoC**:
  - Highly testable as it separates business logic and UI.
  - Tests can be written for streams, events, and states.
  - However, it can be harder to implement due to the boilerplate involved with streams and managing multiple streams.

- **Provider**:
  - Easy to use and understand, but might not be as flexible for more advanced use cases.
  - Testable but can require more setup if the app grows larger.
  - No direct support for more complex state management like BLoC.

- **Riverpod**:
  - Offers more flexibility and modularity, allowing you to combine providers and manage dependencies with greater ease.
  - Extremely testable, with built-in support for mocking and observing state.
  - Allows better handling of asynchronous state and stream-based data.

## 3. **Performance and Learning Curve**
- **BLoC**:
  - Steeper learning curve due to streams and reactive programming concepts.
  - Provides high performance but requires good understanding of streams and event-driven architecture.
  
- **Provider**:
  - Easy to learn and use, with minimal boilerplate.
  - Good performance, but may require optimizations (e.g., using `Consumer` widgets) as the app grows larger.

- **Riverpod**:
  - Has a slightly steeper learning curve than Provider but is easier than BLoC.
  - Performance is similar to Provider but with improvements in error handling, state persistence, and modularity.
  - Handles complex use cases such as async data and combining providers more effectively than the other two.

---

## Summary

| Feature                    | **BLoC**                  | **Provider**              | **Riverpod**             |
|----------------------------|---------------------------|---------------------------|--------------------------|
| **State Management Type**   | Streams & Sinks           | ChangeNotifier + Listeners| Providers, Auto Disposal  |
| **Testability**             | High                      | Moderate                  | High                     |
| **Learning Curve**          | Steep                     | Easy                      | Moderate                 |
| **Flexibility**             | Low                       | Low                       | High                     |
| **Performance**             | High                      | Moderate                  | High                     |

---

## Conclusion
- **BLoC** is ideal for complex apps with highly decoupled business logic.
- **Provider** is a simple and easy-to-use solution for straightforward state management.
- **Riverpod** is the most flexible and powerful option, offering a great balance of performance and usability for larger and more complex apps.


## Video Demonstration

You can watch the video demonstration of the app here:

[Click Here to See the Demonstration Video of Course App](https://drive.google.com/file/d/1LPnqV1YKutZ2CdFeOHMYkWNJBCxJFVgF/view?usp=sharing)





