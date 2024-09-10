# Sui Object Model Workshop

When learning Sui Move, developers are encouraged to use best practices to utilize the Sui object model and ensure on-chain object composability. Developers learn to write composable move code in a timely manner, but struggle to verify their code by deploying and executing the functionality on chain. The key to mastering the Sui object model is to pair your Sui move development sessions with interacting with on-chain objects via PTBs (Programmable Transaction Blocks). This workshop will guide you through the process of writing Sui Move code, deploying it to the Sui blockchain, and interacting with on-chain objects via PTBs.

# Table of Contents
- [Sui Object Model Workshop](#sui-object-model-workshop)
- [Table of Contents](#table-of-contents)
- [Environment Setup](#environment-setup)
- [Lessons](#lessons)
  - [Handling Returned Objects](#handling-returned-objects)
    - [Exercise](#exercise)

# Environment Setup

Before we start, we need to set up our environment.

Navigate to the `scripts` directory and run the following command: 

```bash
yarn init-keypair
```

This will generate and fund a new keypair for you to use in the workshop. Make sure not to use this keypair in any production environments.


# Lessons

## Handling Returned Objects

One of the best practices when writing Sui Move packages is to avoid self-transfers. In other words, avoid transferring objects to the sender of the transaction, and instead return the object from the current function. This allows a caller or programmable transaction block to use the object however they see fit. 

For example, avoid this: 

```move

public struct NewObject has key {
  id: UID
}

public fun new(ctx: &mut TxContext) {
  let new_object = NewObject{
    id: object::new(ctx),
  };

  transfer::transfer(new_object, ctx.sender());
}
  
```

Instead, do this:

```move

public struct NewObject has key {
  id: UID
}

public fun new(ctx: &mut TxContext): NewObject {
  let new_object = NewObject{
    id: object::new(ctx),
  };

  new_object
}
  
```

This is easy enough to do, but in most cases (when the object doesn't have the [`drop` ability](https://move-book.com/reference/abilities.html?highlight=drop#drop)), if the returned object is not handled properly, the transaction will fail.

In this lesson, you learn how to handle returned objects properly.

### Exercise

View the contents [`banana.move`](./lessons/returning_objects/banana_without_display/sources/banana_without_display.move). There is a deployed instance of this package on the Sui blockchain. The address of the package is [`0xadfb946c8c887446d284dae80ac8501c02ec9b9157babb96ca884773bfbb7771`](https://suiscan.xyz/testnet/object/0xadfb946c8c887446d284dae80ac8501c02ec9b9157babb96ca884773bfbb7771/txs). Navigate to [`scripts/lessons/return_objects/exercise.ts`](./scripts/src/lessons/return_objects/exercise.ts) and complete the exercise.