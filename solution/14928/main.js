const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const N = token.next().value;
let remainder = 0;
for (let i = 0; i < N.length; ++i) {
  remainder = (remainder * 10 + N.codePointAt(i) - 48) % 20000303;
}
line.push(remainder);
console.log(line.join("\n"));
