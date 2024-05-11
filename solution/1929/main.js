const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const M = +token.next().value;
const N = +token.next().value;
const is_prime = Array.from({length: N + 1}).map(() => true);
for (let i = 2; i <= N; ++i) {
  if (is_prime[i]) {
    if (i >= M) {
      line.push(i);
    }
    for (let j = 2 * i; j <= N; j += i) {
      is_prime[j] = false;
    }
  }
}
console.log(line.join("\n"));
