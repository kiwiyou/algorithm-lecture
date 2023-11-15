const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const T = +token.next().value;
for (let i = 0; i < T; ++i) {
  const a = +token.next().value;
  const b = +token.next().value;
  line.push(a + b);
}
console.log(line.join("\n"));
