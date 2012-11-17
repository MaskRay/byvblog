'use continuation'
fs = require 'fs'
child_process = require 'child_process'

opencc = (config) ->
  (contents, next) ->
    try
      tmpFilename = '/tmp/opencc_' + Math.random()
      fs.writeFile tmpFilename, contents, obtain()
      child_process.exec 'opencc -c ' + config + ' -i ' + tmpFilename, obtain(stdout, stderr)
      fs.unlink tmpFilename
      next null, stdout
    catch err
      next err

exports.zhsToZht = opencc 'zhs2zht.ini'
exports.zhtToZhs = opencc 'zht2zhs.ini'
