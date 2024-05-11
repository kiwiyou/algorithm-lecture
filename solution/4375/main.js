const { readFileSync } = require("fs");
const token = readFileSync(0, { encoding: "ascii" })
  .split(/\s+/)
  [Symbol.iterator]();
const line = [];

while (true) {
  const n = Number.parseInt(token.next().value);
  if (Number.isNaN(n)) break;
  let length = 1;
  let remainder = 1 % n;
  while (remainder != 0) {
    remainder = (remainder * 10 + 1) % n;
    length++;
  }
  line.push(length);
}
console.log(line.join("\n"));
