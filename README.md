
# Reduxion-iOS


### TL;DR
Easy-to-implement, best-practice Unidirectional Data Flow for iOS apps, featuring:  
- Loosely-coupled layers for View / Business Logic / Services / Data
- Composable business logic, in single-responsibility units
- Good separation of concerns facilitating automated testing (TDD/BDD)
- Ability to switch entire application from real to mock services using one line of code
- Ability to easily persist & recall the entire state of the application
- Ability to easily add time travel (rewind/fast-forward) between different states of the application

~

### Conceptual Overview

Reduxion-iOS is a Clean Architecture implementation, based on the patterns of:
- [Unidirectional data flow](https://duckduckgo.com/?q=unidirectional%20data%20flow)
- [Redux's unified "state container" data model](https://duckduckgo.com/?q=redux%20%22state%20container%22)

It is a custom implementation, inspired in part by [Redux-iOS](https://github.com/armin/Redux-iOS) by Armin Kroll.

~

### Block Diagram
![](./Reduxion%20iOS/Documentation/reduxion-ios-architecture-block-diagram.png)

~

### How to Use
Please see sample app for usage patterns.

~

### Future Milestones
- SwiftUI and Combine (and other modernizations) in the sample app

~

### Special Thanks
- [Armin Kroll](https://twitter.com/persival)
- [Benjamin Encz](https://twitter.com/benjaminencz)
- ["Uncle Bob" Martin](https://twitter.com/unclebobmartin)
- ... and everyone else who's been an inspiration toward *Clean Code*.  Thanks.


Author:  
[Ron Diamond](https://twitter.com/ron_diamond)  
