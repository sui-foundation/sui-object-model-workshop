module banana_without_display::banana {

  /*
    Struct for defining the Banana object type

    Abilities: 
      - key: allows this type to be an object on Sui
      - store: allows this type to be freely transferrable by its owner and able to be wrapped in other objects

    Attributes: 
      - id: The object id of this object (required when using key ability)

    Further reading: 
      - key ability: https://move-book.com/storage/key-ability.html?highlight=key#the-key-ability
      - store ability: https://move-book.com/storage/store-ability.html?highlight=store#ability-store
  */
  public struct Banana has key, store {
    id: UID,
  }

  /*
    Creates and returns a new Banana object.
  */
  public fun new(ctx: &mut TxContext): Banana {
    Banana {
      id: object::new(ctx)
    }
  }
}