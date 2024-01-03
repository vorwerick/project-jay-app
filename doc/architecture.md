# Architecture


Application is split into four layers:
- [Domain](./Layers/Domain.md)
- [Application](./Layers/Application.md)
- [Infrastructure](./Layers/Infrastructure.md)
- [Presentation](./Layers/Presentation.md)

Diagram below is from reso coder, designed for flutter
![DDD-Flutter-Diagram-v3.svg](res/DDD-Flutter-Diagram-v3.svg)

## Knowledge sources

Valid sources to study

- [Eric Evans](https://www.domainlanguage.com/)
- [Martin Fowler](https://martinfowler.com/)
- [Milan Jovanovic](https://www.youtube.com/@MilanJovanovicTech)
    - [Linkedin articles](https://www.linkedin.com/in/milan-jovanovic/recent-activity/all/)
    - [Value Objects in .NET (DDD Fundamentals)](https://www.milanjovanovic.tech/blog/value-objects-in-dotnet-ddd-fundamentals)
    - [How To Approach Clean Architecture Folder Structure](https://www.milanjovanovic.tech/blog/clean-architecture-folder-structure)
- [Robert C. Martin (Uncle Bob)](https://blog.cleancoder.com/)
    - [Video presentations](https://www.linkedin.com/in/rahmouni-mohamed/recent-activity/articles/)
- [CodeOpinion](https://www.youtube.com/@CodeOpinion)
- [Mark Richards](https://www.youtube.com/@markrichards5014/videos)
- [Kamil Grzybek](https://www.kamilgrzybek.com/blog/categories/ddd)
- [hgraca](https://herbertograca.com/2015/09/07/book-review-domain-driven-design-by-eric-evans-1-crunching-knowledge/)
- [Reso Coder](https://resocoder.com/)
  - Good source for flutter, it contains some DDD mistakes but overall good 

--- 

## Dev Concepts

- Anemic domain model
- Fragile base class
    - [Wiki: Fragile base class](https://en.wikipedia.org/wiki/Fragile_base_class)
- Leaking domain
    - [Avoid leaking domain logic](https://www.mscharhag.com/architecture/leaking-domain-logic)
- Repository pattern
    - [DAO vs Repository Patterns](https://www.baeldung.com/java-dao-vs-repository)
- Aggregates
- Liskov Substitution Principle
    - [What Is Liskov Substitution Principle (LSP)? With Real World Examples!](https://blog.knoldus.com/what-is-liskov-substitution-principle-lsp-with-real-world-examples/)
- Bounded context
    - [by Fowler](https://martinfowler.com/bliki/BoundedContext.html)
- ACID
- Transaction script
    - [by Fowler](https://martinfowler.com/eaaCatalog/transactionScript.html)
- CQRS
    - [By Fowler](https://martinfowler.com/bliki/CQRS.html)
- Single-responsibility principle
    - [Single Responsibility Principle in Java](https://www.baeldung.com/java-single-responsibility-principle)
- SOLID
    - [SOLID Definition – the SOLID Principles of Object-Oriented Design Explained]([https://www.freecodecamp.org/news/solid-principles-single-responsibility-principle-explained/](https://www.freecodecamp.org/news/solid-principles-single-responsibility-principle-explained/))
- Separation of concerns
    - **Do one thing**: A function should do just one thing and do it well.
    - **Single Responsibility Principle**: A given method/class/component should have a single reason to change.
    - **Dependency Injection**: As much as possible, class dependency should be provided by objects outside of the class.
    - **Code Architecture**: i.e Clean Architecture.
    - [Separation of Concerns in Software Design](https://nalexn.github.io/separation-of-concerns/)
- Refactoring
    - [REFACTORING A FEATURE ENVY CODE | TOWARDS LESS COUPLED CODE, ADHERING TO THE 'TELL DON'T ASK' PRINCIPLE](https://www.haselt.com/blog/refactoring-a-feature-envy-code)
- DRY - Do not repeat your self
    - [DRY is about knowledge](https://verraes.net/2014/08/dry-is-about-knowledge/)
        - Code duplication is not the issue.

Other

- [Result object vs throwing exceptions](https://softwareengineering.stackexchange.com/questions/405038/result-object-vs-throwing-exceptions)
- [Domain model purity vs. domain model completeness (DDD Trilemma)](https://enterprisecraftsmanship.com/posts/domain-model-purity-completeness/)
- [Covariance and contravariance (computer science)](https://en.wikipedia.org/wiki/Covariance_and_contravariance_(computer_science))
- [GivenWhenThen](https://martinfowler.com/bliki/GivenWhenThen.html)
- [Replace Conditional with Polymorphism](https://refactoring.guru/replace-conditional-with-polymorphism)

---

## Dependency Injection

- [Difference Between Inversion of Control and Dependency Injection](https://www.geeksforgeeks.org/spring-difference-between-inversion-of-control-and-dependency-injection/)

---

## Architectures

- [Awesome software architecture](https://awesome-architecture.com/)
    - Awesome list of knowledge srouces sorted by topic
- [Software Architecture Guide by Fowler](https://martinfowler.com/architecture/)
- [DDD, Hexagonal, Onion, Clean, CQRS, … How I put it all together](https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/)
- [Business-Logic Layer](https://www.geeksforgeeks.org/business-logic-layer/)
- [Y: Top 5 Flutter Tips for Big Projects](https://www.youtube.com/watch?v=QETClbz1sz8)
- [Github: Flutter arch samples](https://github.com/brianegan/flutter_architecture_samples)

### DDD & clean architecture

**Some of resources need validation**

- [Uncle Bob: The clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [How To Use Domain-Driven Design In Clean Architecture](https://www.youtube.com/watch?v=1Lcr2c3MVF4)
- [Flutter Retrofit, implementation in Clean Architecture with unit tests](https://www.etiennetheodore.com/flutter-retrofit-implementation-in-clean-architecture-with-unit-tests/)
- [Domain-Driven Refactoring: Intro](https://www.jimmybogard.com/domain-driven-refactoring-intro/)
- [Domain-Driven Design in Practice Pluralsight course](https://enterprisecraftsmanship.com/posts/domain-driven-design-in-practice-pluralsight-course/)
- [Flutter firebase ddd course: domain driven design principles](https://resocoder.com/2020/03/09/flutter-firebase-ddd-course-1-domain-driven-design-principles/#t-1703002362378)
- [How To Approach Clean Architecture Folder Structure](https://www.milanjovanovic.tech/blog/clean-architecture-folder-structure)
- [Where To Place Dtos In Clean Architecture?](https://www.architecturemaker.com/where-to-place-dtos-in-clean-architecture/)
- [DomainDrivenDesign by Fowler](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [Y: Clean Architecture in Flutter - All You Need to Know!](https://www.youtube.com/watch?v=zon3WgmcqQw)
- [Y: Flutter Clean Architecture - How to Use Clean Architecture with Flutter](https://www.youtube.com/watch?v=ZNMz2hOrddo&list=PLCAZyR6zw2pznlDPLCMUGUVr7uFRlMpTs)
- [Y: Clean Architecture is not Domain-Data-Presentation.](https://markonovakovic.medium.com/clean-architecture-is-not-domain-data-presentation-e368d7ff8579)
- [An Introduction to Flutter Clean Architecture](https://medium.com/ruangguru/an-introduction-to-flutter-clean-architecture-ae00154001b0)
    - Good abstract
    - not best package design for big
- [Github: Flutter Clean Architecture News App](https://github.com/mahdinazmi/Flutter-Clean-Architecture-News-App/blob/main/lib/feature/domain/use-cases/use-cases.dart)

---

## Project structure

There are several approaches to folder structure
- by feature
- by technical suppose
- by layer

- [Flutter: Mastering Modularization — In Several Ways](https://medium.com/flutter-community/mastering-flutter-modularization-in-several-ways-f5bced19101a)
- [Flutter – File Structure](https://www.geeksforgeeks.org/flutter-file-structure/)
- [Flutter Project Structure: Feature-first or Layer-first?](https://codewithandrea.com/articles/flutter-project-structure/)
- [Layer-First Or Feature-First: How A Good Flutter Project Structure Pays Off](https://kodytechnolab.com/blog/layer-first-or-feature-first-flutter-project-structure/)
- [Flutter Project Structure, Features first or Layers first?](https://www.linkedin.com/pulse/flutter-project-structure-features-first-layers-loic-ngou-/)
- [A Comprehensive Guide to Creating a Scalable Folder Structure for Flutter Apps](https://dev.to/yatendra2001/a-comprehensive-guide-to-creating-a-scalable-folder-structure-for-flutter-apps-1o5i)
- [Folder structure for Flutter with clean architecture. How I do.](https://felipeemidio.medium.com/folder-structure-for-flutter-with-clean-architecture-how-i-do-bbe29225774f)
- [Scalable Folder Structure for Flutter Applications](https://medium.com/flutter-community/scalable-folder-structure-for-flutter-applications-183746bdc320)
- [How To Approach Clean Architecture Folder Structure](https://www.milanjovanovic.tech/blog/clean-architecture-folder-structure)
