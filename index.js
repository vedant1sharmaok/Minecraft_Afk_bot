require('dotenv').config()
require('./health/server')

const { startBots } = require('./src/manager')
startBots()
