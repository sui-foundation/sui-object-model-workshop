module scavenger::trophy {

  public struct Trophy has key, store {
    id: UID,
  }

  public fun new(ctx: &mut TxContext): Trophy {
    Trophy {
      id: object::new(ctx)
    }
  }

}