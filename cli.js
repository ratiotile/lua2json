#! /usr/bin/env node
const path = require('path')
const fs = require('fs')
const parser = require('./parser')

var args = process.argv.slice(2)
var target = args[0]
var target_path = path.resolve(target)

console.log("target path: ", path.resolve(target_path))

if(fs.lstatSync(target_path).isDirectory()){
  procDir(target_path)
}
else if(fs.lstatSync(target_path).isFile()){
  procFile(target_path)
}
else{
  console.log("Error: Target is not directory or file")
}

function procDir(dir){
  console.log("Processing directory", dir)
  fs.readdir(dir, function(err, list){
    if(err) return done(err)
    list.forEach(function(file){
      file = path.resolve(dir, file)
      fs.stat(file, function(err, stat){
        if(stat.isDirectory()) {
          procDir(file)
        }
        else if(stat.isFile()){
          procFile(file)
        }
      })
    })
  })
}

function procFile(filepath){
  const filename = path.basename(filepath)
  const dir = path.dirname(filepath)
  const ext = path.extname(filepath)
  if(ext == '.json') return
  console.log("Processing file", filename)
  fs.readFile(filepath, "utf8", function(err, data){
    if(err) throw err;
    const result = parser.parse(data)
    const outputfile = path.basename(filepath, ext) + ".json"
    const outputpath = path.join(dir, outputfile)
    console.log(outputpath)
    fs.writeFile(outputpath, JSON.stringify(result, 0, 2),
      {
        encoding: 'utf8',
        flag: 'w'
      },
      function(err){
        if(err) throw err;
        console.log("converted", filename, "to", outputfile)
    })
  })
}
