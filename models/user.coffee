'use continuation'
mongoose = require '../lib/mongoose'

userSchema = new mongoose.Schema
  name:
    type: String
    index: true
    unique: true
  password: String

module.exports = User = mongoose.model 'User', userSchema

User.authenticate = (user, next) ->
  return next 'Invalid Username' if not user?
  User.findOne {name:user.name}, cont(err, dbUser)
  return next err if err
  return next 'Invalid Username' if not dbUser?
  if passwordHash user.password != dbUser.password
    next 'Invalid Password'
  else
    next null, dbUser.toObject()

passwordHash = (password) ->
  password
