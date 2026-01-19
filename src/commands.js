const { goals } = require('mineflayer-pathfinder')

module.exports = (bot) => {
  bot.on('chat', (username, message) => {
    if (username !== process.env.OWNER_USERNAME) return
    if (!message.startsWith('!')) return

    const cmd = message.slice(1)

    if (cmd === 'come') {
      bot.pathfinder.setGoal(
        new goals.GoalBlock(-265, 63, 354),
        true
      )
      bot.chat('Moving.')
    }

    if (cmd === 'stop') {
      bot.pathfinder.setGoal(null)
      bot.chat('Stopped.')
    }
  })
}
