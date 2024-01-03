#Architecture 

- Define basic rules
- Most inner layer
- Not any external dependency
- Only programing language dependant
- Not implementation - only abstraction
- [Entity vs Value Object: the ultimate list of differences](https://enterprisecraftsmanship.com/posts/entity-vs-value-object-the-ultimate-list-of-differences/)
- [The Domain layer folder structure](https://twitter.com/mjovanovictech/status/1706191113420189770)
- [Difference between Entity and DTO](https://stackoverflow.com/questions/39397147/difference-between-entity-and-dto)

### Entity

- Must have identifikator (ID)
- Obect are compared by ID
	- Identifier equality
- Can contain logic
- Can be mutable
- In Java world enity as name is used for representating db table

```Dart
abstract class Entity{

	final Uuid _id;
	
	Entity(this._id_)
}
```

### Value

- Value objects should be immutable
- Dont have own identity
- Only very simple logic can be implemented
- [Value Objects explained](https://enterprisecraftsmanship.com/posts/value-objects-explained/)

>  if you can’t make a value object immutable, then it is not a value object.



```Dart
class Address{

	final String address;
// Should contain validation
}
```

### Repository

- [DAO vs Repository Patterns](https://www.baeldung.com/java-dao-vs-repository)
- Only abstaction
- Interface for accessing domain object
- Mediates between the domain and data layers

```Dart
abstract interface class MachineRepository{

	void addMachine (Machine m);

	Machine? getMachine(Uuid id);

}
```

## Services

- Services in domain are allowed
- The should be domain relevant. 
- Example: Bank transaction betwen two accounts