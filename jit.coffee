'use continuation'
fs = require 'fs'
path = require 'path'
util = require 'util'
child_process = require 'child_process'

module.exports = (options, next) ->
  compiled = []
  continuation = options.continuation
  
  if continuation
    try
      updateContinuation continuation, obtain(updated)
    catch err
      return next err
    compiled = compiled.concat updated
  
  next null, compiled

updateContinuation = (continuation, next) ->
  update continuation, 'continuation "%s" -o "%s"', next

update = (task, command, next) ->
  compiled = []
  try
    fs.readdir task.src, obtain(srcs)
    fs.readdir task.dest, obtain(dests)
    for src in srcs
      srcPath = path.join task.src, src
      dest = (path.basename src, path.extname(src)) + '.js'
      destPath = path.join task.dest, dest

      compile = false
      fs.exists destPath, cont(destExists)
      if destExists
        fs.lstat srcPath, obtain(srcStat)
        fs.lstat destPath, obtain(destStat)
        srcMtime = srcStat.mtime
        destMtime = destStat.mtime
        #If src is newer than dest, recompile it
        if srcMtime > destMtime
          compile = true
      else
        #If dest does not exist, compile it
        compile = true
      
      continue if not compile
      command = util.format command, srcPath, destPath
      child_process.exec command, obtain(stdout, stderr)
      if stdout or stderr
        throw new Error 'Complilation failed: ' + stdout + stderr
      compiled.push srcPath
  catch err
    return next err
  next null, compiled
