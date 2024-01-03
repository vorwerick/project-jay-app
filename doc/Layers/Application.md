---
tags:
  - Architecture
  - Flutter
---
- Extends business rules by use cases
- Use-Case are single responsible
- Can be realized by command patter, CQRS, Transcrypt
- In flutter we can use Bloc

## Dto

- Data Transfer object
- Object used by UI
-  [Stop using Data Transfer Objects (DTOs) in your code](https://anthony-trad.medium.com/stop-using-data-transfer-objects-dtos-in-you-code-62b58f97278e)
- [The Disadvantages of Using Data Transfer Objects (DTOs) and How to Address Them in Your Codebase](https://www.linkedin.com/pulse/disadvantages-using-data-transfer-objects-dtos-how-uzc%C3%A1tegui-pescozo/)
- [The DTO dilemma](https://professionalbeginner.com/the-dto-dilemma)

## Use-Cases

- Bussiness use case

```Dart
final class StoreMachine{

	final Machine _m;
	final MachineRepository _repository;

	StoreMachine (MachineRepositor repository, Machine m);

	void excetute(){

		_repository.add(_m);
	}
}
```

## Services

- Abstraction for service necessary to realize use cases

```Dart
abstract interface class AuthService{

	void authorize();

}
```

