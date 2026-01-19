module.exports = (bot) => {
  let eating = false

  setInterval(async () => {
    if (!bot.food || eating) return
    if (bot.food > 14) return

    const foodItem = bot.inventory.items().find(item =>
      item.name.includes('bread') ||
      item.name.includes('carrot') ||
      item.name.includes('potato') ||
      item.name.includes('beef') ||
      item.name.includes('chicken')
    )

    if (!foodItem) return

    try {
      eating = true
      await bot.equip(foodItem, 'hand')
      await bot.consume()
    } catch {}
    eating = false
  }, 4000)
}
