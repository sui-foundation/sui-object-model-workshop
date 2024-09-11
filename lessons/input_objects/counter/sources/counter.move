module counter::counter {

  /*
    Struct for defining the Counter object type

    Abilities: 
      - key: allows this type to be an object on Sui

    Attributes: 
      - id: The object id of this object (required when using key ability)
      - count: The current value of the counter

    Further reading: 
      - key ability: https://move-book.com/storage/key-ability.html?highlight=key#the-key-ability
  */
  public struct Counter has key {
    id: UID, 
    count: u64,
  }

  /* 
    Init function that creates and shares a Counter object.
    
    This function will be called once and only once during the package deployment.

    Further reading: 
      - Shared objects: https://docs.sui.io/concepts/object-ownership/shared
  */
  fun init(ctx: &mut TxContext) {
    transfer::share_object(
      Counter {
        id: object::new(ctx), 
        count: 0,
      }
    );
  }

  public fun increment(counter: &mut Counter) {
    counter.count = counter.count + 1;
  }
}