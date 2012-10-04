'use continuation'
fs = require 'fs'
path = require 'path'
util = require 'util'
child_process = require 'child_process'
mkdirp = require 'mkdirp'

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
    src = path.join opts.continuation.src, src
    dest = path.join opts.continuation.dest, dest
    updateContinuationSingle src, dest, cont(err)
  next err if next

updateContinuationSingle = (src, dest, next) ->
  updateSingle {
    src: src,
    dest: dest,
  }, 'continuation "%s" -o "%s"', next

updateAll = (category, updater, next) ->
  compiled = []
  
  find = (dir, next) ->
    try
      fs.readdir path.join(category.src, dir), obtain(srcs)
      for srcName in srcs
        src = path.join category.src, dir, srcName
        fs.lstat src, obtain(stat)
        if stat.isDirectory()
          find path.join(dir, srcName), obtain()
        else
          dest = (path.basename src, path.extname(src)) + '.js'
          dest = path.join opts.continuation.dest, dir, dest
          updater src, dest, obtain(updated)
          compiled.push src if updated
    catch err
      return next err
    
    next()
  
  find '', cont(err)  
  next err, compiled

updateSingle = (task, command, next) ->
  try
    compile = false
    fs.exists task.dest, cont(destExists)
    if destExists
      fs.lstat task.src, obtain(srcStat)
      fs.lstat task.dest, obtain(destStat)
      srcMtime = srcStat.mtime
      destMtime = destStat.mtime
      #If src is newer than dest, recompile it
      if srcMtime > destMtime
        compile = true
    else
      #If dest does not exist, compile it
      mkdirp path.dirname(task.dest), obtain()
      compile = true
    
    return next null, false if not compile
    
    command = util.format command, task.src, task.dest
    child_process.exec command, obtain(stdout, stderr)
    if stdout or stderr
      throw new Error 'Complilation failed: ' + stdout + stderr
    console.log path.basename(task.src), 'compiled'
    
  catch err
    return next err
  next null, true
