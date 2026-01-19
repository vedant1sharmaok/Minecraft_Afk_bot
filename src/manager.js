const { createBotInstance } = require('./bot')

function startBots() {
  const count = Number(process.env.BOT_COUNT || 1)

  for (let i = 0; i < count; i++) {
    setTimeout(() => {
      createBotInstance(i)
    }, i * 8000)
  }
}

module.exports = { startBots }
