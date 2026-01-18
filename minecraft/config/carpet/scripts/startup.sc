__config() -> {
  'scope': 'global',
  'events': ['player_joined']
}

player_joined(player) -> (
  if(player == 'vedantiron',
    (
      print('AFK bot joined, starting Baritone navigation');
      task(140, run('#goto -265 63 354'));
    )
  )
);
