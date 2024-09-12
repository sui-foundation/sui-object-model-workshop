module scavenger::vault {

  use sui::coin;
  use sui::clock;
  use sui::balance;
  use sui::sui::SUI;

  use scavenger::key;

  public struct Vault has key {
    id: UID,
    balance: balance::Balance<SUI>,
    withdrawal_amount: u64, 
    code: u64
  }

  public struct AdminCap has key, store {
    id: UID, 
    vault_id: ID
  }

  public fun new(
    sui_coins: coin::Coin<SUI>, 
    withdrawal_amount: u64, 
    code: u64,
    ctx: &mut TxContext
  ): AdminCap {
    let new_vault = Vault {
      id: object::new(ctx),
      balance: coin::into_balance(sui_coins),
      withdrawal_amount, 
      code
    };

    let new_admin_cap = AdminCap {
      id: object::new(ctx), 
      vault_id: new_vault.id.to_inner()
    };

    transfer::share_object(
      new_vault
    );

    new_admin_cap  
  }

  public fun withdraw(vault: &mut Vault, key: key::Key, ctx: &mut TxContext): coin::Coin<SUI> {
    
    assert_valid_key_code(vault, &key);

    key.delete();
    let new_coin = coin::from_balance(
      balance::split(
        &mut vault.balance, 
        vault.withdrawal_amount
      ), 
      ctx
    );

    new_coin
    
  }

  public fun empty(vault: &mut Vault, admin_cap: AdminCap, ctx: &mut TxContext): coin::Coin<SUI> {
    assert_valid_admin_cap(vault, &admin_cap);

    let AdminCap {
      id: admin_cap_id, 
      vault_id: _
    } = admin_cap;

    admin_cap_id.delete();

    let vault_balance_value = vault.balance.value();
    let new_coin = coin::from_balance(balance::split(&mut vault.balance, vault_balance_value), ctx);

    new_coin

  }

  fun assert_valid_key_code(vault: &Vault, key: &key::Key) {
    assert!(vault.code == key.get_code());
  }

  fun assert_valid_admin_cap(vault: &Vault, admin_cap: &AdminCap) {
    assert!(vault.id.to_inner() == admin_cap.vault_id);
  }

}