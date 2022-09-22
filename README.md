
# Reduxion-iOS


### TL;DR
Easy-to-implement, best-practice Clean Architecture for iOS apps, featuring:  

+ Loosely-coupled layers
    - for View / Business Logic / Data / Services
+ Composable business logic
    - in single-responsibility units
+ Good separation of concerns
    - facilitating automated testing (TDD/[BDD](https://duckduckgo.com/?q=behavior+driven+development)) that’s performant and not brittle
+ Ability to switch the entire application between real and mock services
    - largely decoupling front-end from back-end development, if needed
    - with one line of code
+ Ability to easily persist & recall the entire state of the application
    - without any database framework at all
+ Ability to easily add time travel (rewind/fast-forward)
    - between different states of the application

---

### Rationale and History

["Introducing Reduxion-iOS"](https://ron-dev.medium.com/introducing-reduxion-ios-9e2ac5dcf054) (Medium.com)

---

### Conceptual Overview

Reduxion-iOS is a Clean Architecture implementation, based on the patterns of:
- [Unidirectional data flow](https://duckduckgo.com/?q=unidirectional%20data%20flow)
- [Redux's unified "state container" data model](https://duckduckgo.com/?q=redux%20%22state%20container%22)

---

### Block Diagram
![](./Reduxion%20iOS/Documentation/reduxion-ios-architecture-block-diagram.png)

---

### How to Use
Please see sample app for usage patterns.

---

### Future Milestones
- SwiftUI and Combine (and other modernizations) in the sample app

---

### Special Thanks
- [Armin Kroll](https://twitter.com/persival) (whose [Redux-iOS](https://github.com/armin/Redux-iOS) helped inspire this implementation)
- [Benjamin Encz](https://twitter.com/benjaminencz) (for evangelizing Redux and Unidirectional Data Flow for iOS)
- ["Uncle Bob" Martin](https://twitter.com/unclebobmartin) (for too many reasons to count)
- ... and everyone else who's been an inspiration toward *Clean Code*.  Thanks.

---

### Author:  
[Ron Diamond](https://www.rondiamond.net)
