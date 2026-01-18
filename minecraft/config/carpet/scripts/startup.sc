__config() -> {
  'scope': 'global',
  'events': ['player_joined']
}

player_joined(player) -> (
  if(player == 'vedantiron',
    (
      print('AFK bot joined, starting navigation');
      task(140, _start_main());
      task(6000, _periodic_check()); // every 5 minutes
    )
  )
);

_start_main() -> (
  run('#stop');
  run('#goto -265 63 354');
);

_fallback() -> (
  print('Primary path failed, using fallback');
  run('#stop');
  run('#goto -260 63 350');
);
