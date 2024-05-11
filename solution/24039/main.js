const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const N = +token.next().value;
let prev = 2, cur = 3;
for (let i = 4; prev * cur <= N; ++i) {
  let is_prime = true;
  for (let j = 2; j * j <= i; ++j) {
    if (i % j == 0) {
      is_prime = false;
      break;
    }
  }
  if (is_prime) {
    prev = cur;
    cur = i;
  }
}
line.push(prev * cur);
console.log(line.join("\n"));
