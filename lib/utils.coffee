crypto = require('crypto')

exports.md5 = (data) ->
  hash = crypto.createHash('md5')
  hash.update data
  hash.digest 'hex'
