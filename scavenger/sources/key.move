module scavenger::key {

  public struct Key {
    code: u64
  }

  public fun new(): Key {
    Key {
      code: 0
    }
  }

  public fun set_code(key: &mut Key, new_code: u64) {
    key.code = new_code;
  }

  public fun get_code(key: &Key): u64 {
    key.code
  }

  public(package) fun delete(key: Key) {
    let Key {
      code: _,
    } = key;
  }
}