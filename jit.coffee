'use continuation'
fs = require 'fs'
path = require 'path'
util = require 'util'
child_process = require 'child_process'

opts = {}

jit = module.exports = (newOpts, next) ->
  if typeof(newOpts) is 'function'
    next = newOpts
    newOpts = opts
  else if newOpts
    opts = newOpts
  
  compiled = []
  
  if opts.continuation
    try
      updateAll opts.continuation, updateContinuationSingle, obtain(updated)
    catch err
      next err if next
      return
    compiled = compiled.concat updated
  
  next null, compiled if next

jit.configure = (newOpts) ->
  opts = newOpts

jit.update = (type, src, dest, next) ->
  if type is 'continuation'
    updateContinuationSingle src, dest, cont(err)
  next err if next

updateContinuationSingle = (src, dest, next) ->
  updateSingle {
    src: src,
    dest: dest,
    srcDir: opts.continuation.src,
    destDir: opts.continuation.dest,
  }, 'continuation "%s" -o "%s"', next

updateAll = (category, updater, next) ->
  compiled = []
  try
    fs.readdir category.src, obtain(srcs)
    for src in srcs
      dest = (path.basename src, path.extname(src)) + '.js'
      updater src, dest, obtain(updated)
      compiled.push src if updated
  catch err
    return next err
  next null, compiled

updateSingle = (task, command, next) ->
  try
    srcPath = path.join task.srcDir, task.src
    destPath = path.join task.destDir, task.dest

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
      
    return next null, false if not compile
    
    command = util.format command, srcPath, destPath
    child_process.exec command, obtain(stdout, stderr)
    if stdout or stderr
      throw new Error 'Complilation failed: ' + stdout + stderr
    console.log task.src, 'compiled'
    
  catch err
    return next err
  next null, true
