module.exports = (bot) => {
  setInterval(() => {
    if (!bot.entity) return
    bot.swingArm('right')
    bot.look(
      Math.random() * Math.PI * 2,
      (Math.random() - 0.5) * Math.PI / 2,
      true
    )
  }, 30000)
}
