import { Transaction } from '@mysten/sui/transactions';
import { Ed25519Keypair } from "@mysten/sui/keypairs/ed25519";
import { getFullnodeUrl, SuiClient } from '@mysten/sui/client';
import { decodeSuiPrivateKey } from '@mysten/sui/cryptography';
import keyPairJson from '../../../keypair.json';


/**
 * 
 * Global variables
 * 
 * These variables are used throughout the exercise below.
 * 
 */
const { secretKey } = decodeSuiPrivateKey(keyPairJson.privateKey);
const keypair = Ed25519Keypair.fromSecretKey(secretKey);
const suiAddress = keypair.getPublicKey().toSuiAddress();

const PACKAGE_ADDRESS = `0xadfb946c8c887446d284dae80ac8501c02ec9b9157babb96ca884773bfbb7771`;

const rpcUrl = getFullnodeUrl("testnet");
const suiClient = new SuiClient({ url: rpcUrl });

/**
 * Returning Objects: Exercise 1
 * 
 * In this exercise, you will be returned a new object from a function and must transfer it to an 
 * address, otherwise, the transaction will abort. 
 * 
 * When finished, run the following command in the scripts directory to test your solution:
 * 
 * yarn return-objects
 * 
 * RESOURCES: 
 * - https://sdk.mystenlabs.com/typescript/transaction-building/basics#transactions
 */
const main = async () => {

  /**
   * Task 1: 
   * 
   * Create a new Transaction instance from the @mysten/sui/transactions module.
   */
  const tx = new Transaction();

  /**
   * Task 2:
   * 
   * Execute the call to the `banana::new` function to the transaction instance.
   * 
   * The target should be in the format {package address}::{module name}::{function name}. The 
   * package address is provided above. The module name is `banana` and the function name is `new`.
   * 
   * HINT: The arguments and typeArguments arguments are optional since this function does not take 
   * any arguments or type arguments.
   */
  const [banana] = tx.moveCall({
    target: `${PACKAGE_ADDRESS}::banana::new`,
  });

  /**
   * Task 3: 
   * 
   * Transfer the newly created banana object to your address. 
   * 
   * Use `tx.transferObjects(objects, address)` - Transfers a list of objects to the specified address.
   * 
   * HINT: Use `suiAddress`` to transfer the object to your address.
   */
  tx.transferObjects([banana], suiAddress);

  /**
   * Task 4: 
   * 
   * Sign and execute the transaction using the SuiClient instance created above.
   * 
   * Print the result to the console.
   */
  const res = await suiClient.signAndExecuteTransaction({
    signer: keypair,
    transaction: tx,
  });
  console.log(res);
  console.log(`Result: https://suiscan.xyz/testnet/tx/${res.digest}`)

}

main();