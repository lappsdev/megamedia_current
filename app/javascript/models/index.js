const files = require.context('.', false, /\.js$/)
const modules = {}
files.keys().forEach((key) => {
    if (key === './index.js') return
    Object.keys(files(key)).forEach((k, i) => {
        modules[k] = Object.values(files(key))[i]


    })
})
console.log(modules)
module.exports = { ...modules }