module scavenger::vault {

  use sui::coin;
  use sui::clock;
  use sui::balance;
  use sui::sui::SUI;

  use scavenger::key;
  use scavenger::trophy;

  public struct Vault has key {
    id: UID,
    unlock_timestamp_seconds: u64,
    balance: balance::Balance<SUI>,
    withdrawal_amount: u64, 
    code: u64
  }

  public fun new(
    sui_coins: coin::Coin<SUI>, 
    unlock_timestamp_seconds: u64, 
    withdrawal_amount: u64, 
    code: u64,
    ctx: &mut TxContext
  ) {
    transfer::share_object(
      Vault {
        id: object::new(ctx),
        balance: coin::into_balance(sui_coins),
        unlock_timestamp_seconds,
        withdrawal_amount, 
        code
      }
    )
  }

  public fun withdraw(vault: &mut Vault, key: key::Key, clock: &clock::Clock, ctx: &mut TxContext): (coin::Coin<SUI>, trophy::Trophy) {
    
    assert_valid_key_code(vault, &key);
    assert_valid_time(vault, clock);

    key.delete();
    let new_coin = coin::from_balance(
      balance::split(
        &mut vault.balance, 
        vault.withdrawal_amount
      ), 
      ctx
    );

    let new_trophy = trophy::new(ctx);

    (new_coin, new_trophy)
    
  }

  fun assert_valid_key_code(vault: &Vault, key: &key::Key) {
    assert!(vault.code == key.get_code());
  }

  fun assert_valid_time(vault: &Vault, clock: &clock::Clock) {
    assert!(vault.unlock_timestamp_seconds < clock::timestamp_ms(clock) / 1000)
  }

}