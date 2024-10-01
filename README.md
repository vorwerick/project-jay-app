# Jay app

Project essentials
- [YouTrack - project management](https://appwizards.youtrack.cloud/)
- [Original android src](https://github.com/vorwerick/JAY-System-Android?tab=readme-ov-file)
- [Original Api in swagger](https://jayserver.telwork.cz/Mobile.API/swagger/)

Package name
> cz.telwork.jay.play

## Project architecture

This project follows the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles.

You can find more about the architecture in the [architecture.md](./doc/architecture.md) file.
It contains the basic rules and principles of the architecture. And also contents to study.

## App UI

![UI design with colors](./doc/res/Jay%20UI%20Colors_exported.png)

## Source control

This section describes the source control rules like git flow, commit messages, etc.

### Commit messages
How to write commits in this repo is described here [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

```bash
<type>[optional scope]: <description>
```

Type can be one of the following:
- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing or correcting existing tests
- chore: Changes to the build process or auxiliary tools and libraries such as documentation generation

**Example**

>feat: allow provided config object to extend other configs