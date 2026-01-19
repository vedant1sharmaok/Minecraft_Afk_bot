const mineflayer = require('mineflayer')
const { pathfinder, Movements, goals } = require('mineflayer-pathfinder')
const antiAfk = require('./antiAfk')
const autoEat = require('./autoEat')
const registerCommands = require('./commands')

function createBotInstance(index) {
  const bot = mineflayer.createBot({
    host: process.env.SERVER_HOST,
    port: Number(process.env.SERVER_PORT),
    username: `${process.env.BOT_BASE_NAME}_${index}`,
    auth: 'offline'
  })

  bot.loadPlugin(pathfinder)

  bot.once('spawn', () => {
    const mcData = require('minecraft-data')(bot.version)
    const movements = new Movements(bot, mcData)

    movements.allowSprinting = true
    movements.allowParkour = true
    movements.allowSwimming = true
    movements.canDig = false

    bot.pathfinder.setMovements(movements)

    bot.pathfinder.setGoal(
      new goals.GoalBlock(-265, 63, 354),
      true
    )

    antiAfk(bot)
    autoEat(bot)
    registerCommands(bot)

    bot.chat('AFK bot online.')
  })

  bot.on('death', () => {
    setTimeout(() => bot.emit('respawn'), 3000)
  })

  bot.on('end', () => {
    setTimeout(() => createBotInstance(index), 5000)
  })

  bot.on('error', () => {})
}

module.exports = { createBotInstance }
