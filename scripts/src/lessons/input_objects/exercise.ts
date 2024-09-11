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

const PACKAGE_ADDRESS = `0xad3225e7d4827f81dc0686177067e1b458e8468ceabcff3456888ce3d806eb8c`;

const COUNTER_ADDRESS = `0x1feb03541d20064d1876c26cfa44514f2e029c8201a2fe12a60589842b9d391d`

const rpcUrl = getFullnodeUrl("testnet");
const suiClient = new SuiClient({ url: rpcUrl });

/**
 * Objects as input: Exercise 1
 * 
 * In this exercise, you use Sui objects as inputs in a PTB to update the value of a shared object.
 * 
 * When finished, run the following command in the scripts directory to test your solution:
 * 
 * yarn input-objects
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
  
  /**
   * Task 2:
   * 
   * Execute the call to the `counter::increment` function to the transaction instance.
   * 
   * The target should be in the format {package address}::{module name}::{function name}. The 
   * package address is provided above. The module name is `counter` and the function name is 
   * `increment`.
   * 
   * Resources: 
   * - Object inputs: https://sdk.mystenlabs.com/typescript/transaction-building/basics#object-references
   */

  /**
   * Task 3: 
   * 
   * Sign and execute the transaction using the SuiClient instance created above.
   * 
   * Print the result to the console.
   */
  
}

main();