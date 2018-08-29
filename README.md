
# Reduxion-iOS

### TL;DR
Easy-to-implement, best-practice Unidirectional Data Flow for iOS apps, featuring:  
- Loosely-coupled layers for View / Business Logic / Services / Data
- Composable business logic, in single-responsibility units
- Designed for unit testability (TDD/BDD)
- Ability to switch entire application from real to mock services using one line of code
- Ability to easily persist & recall the entire state of the application

~

### Background

How *Reduxion-iOS* came about, and the problems it's intended to solve:  
[**Introducing "Reduxion iOS"**](https://medium.com/p/6e1cdf5d7570/)  (Medium.com)

~

### Essential Architectural Overview  
A few resources essential to understanding the underlying design patterns:

[***The Principles of Clean Architecture***](https://www.youtube.com/watch?v=o_TH-Y78tt4&t=10m45s) - Robert Martin  
Superb overview of clean architectural design principles [1 hour].  Highly recommended.

[***Unidirectional Data Flow: Shrinking Massive View Controllers***](https://realm.io/news/benji-encz-unidirectional-data-flow-swift/) - Benjamin Encz  
Video explaining the unidirectional data flow design pattern and its advantages in depth [31+ minutes].

[***Redux for iOS***](http://blog.jtribe.com.au/redux-for-ios/) - Armin Kroll  
Good, concise overview (of one available library which has been modified for use in this project).


~

### Block Diagram
![](./_Documentation/reduxion-ios-architecture-block-diagram.png)

~

### Getting Started
*[how to use]*

~

### Possible future features
- Framework, with sample app
- Carthage support
- Formatter classes (for displayed data)
- ... more

~
### Special Thanks
- [Armin Kroll](https://twitter.com/persival)
- [Benjamin Encz](https://twitter.com/benjaminencz)
- ["Uncle Bob" Martin](https://twitter.com/unclebobmartin)
- ... and everyone else who's been an inspiration on the path to *Clean Code*.  Thanks.


Author:  
[Ron Diamond](https://twitter.com/ron_diamond)  
[PoP contact form ?]
