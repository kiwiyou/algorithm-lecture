const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

const T = +token.next().value;
for (let i = 0; i < T; ++i) {
  const P = +token.next().value;
  const Q = +token.next().value;
  let prev = 1, cur = 0;
  for (let i = 0; i < P; ++i) {
    const next = (prev + cur) % Q;
    prev = cur;
    cur = next;
  }
  line.push('Case #' + (i + 1) + ': ' + cur);
}
console.log(line.join("\n"));
