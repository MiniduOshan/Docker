const sum = require('../index.js');

// Simple test
const a = 4;
const b = 6;
const expected = 10;

if (sum(a, b) === expected) {
  console.log('Test passed ✅');
  process.exit(0); // Success
} else {
  console.error('Test failed ❌');
  process.exit(1); // Fail
}
