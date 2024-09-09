import { writeFile } from "fs/promises";

export async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Asynchronous example
export async function writeToFile(filename: string, content: string) {
  try {
    await writeFile(filename, content);
  } catch (error) {
    console.error('Error writing file:', error);
  }
}