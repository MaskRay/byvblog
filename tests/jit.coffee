'use continuation'
path = require 'path'
jit = require '../jit'

try
  jit
    continuation:
      src: path.join __dirname, '..', 'assets', 'js'
      dest: path.join __dirname, '..', 'public', 'js'
  , obtain compiled
catch err
  console.error err
console.log compiled
