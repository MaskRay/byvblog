'use continuation'
path = require 'path'
jit = require '../jit'

jit.configure
  continuation:
    src: path.join __dirname, '..', 'assets', 'js'
    dest: path.join __dirname, '..', 'public', 'js'

jit.update 'continuation', 'blog.coffee', 'blog.js', obtain()

try
  jit obtain compiled
catch err
  console.error err
console.log compiled
