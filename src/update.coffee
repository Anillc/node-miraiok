os = require 'os'
shelljs = require 'shelljs'
fs = require 'fs'
fetch = require 'node-fetch'
  .default
util = require 'util'
pipe = util.promisify require('stream').pipeline

platform = os.platform()
arch = os.arch()
suffix = if platform == 'windows' then '%2Eexe' else ''
fileSuffix = if suffix != '' then '.exe' else ''

if arch == 'x32'
  arch = '386'

if arch == 'x64'
  arch = 'amd64'

if platform == 'android'
  platform = 'linux'

downUrl = "https://cdn.jsdelivr.net/gh/Anillc/miraiok-resource@latest/miraiok/miraiOK_#{platform}_#{arch}#{suffix}"

module.exports = ->
  shelljs.rm '-rf', 'miraiok'
  shelljs.mkdir 'miraiok'
  mo = await fetch downUrl
  if !mo.ok
    console.log '更新失败，请使用miraiok update重试'
    return
  stream = fs.createWriteStream "miraiok/miraiOK#{fileSuffix}"
  try
    await pipe mo.body, stream
  catch e
    console.log '更新失败，请使用miraiok update重试'
    console.log e
    return
  shelljs.chmod '+x', "miraiok/miraiOK#{fileSuffix}"
  console.log '更新成功！'
