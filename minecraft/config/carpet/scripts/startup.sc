__config() -> {
  'scope': 'global',
  'events': ['player_joined']
}

player_joined(player) -> (
  if(player == 'vedantiron',
    (
      print('AFK bot joined, starting navigation');

      task(140, _start_main());
      task(200, _log_distance());
      task(6000, _periodic_check());
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

_periodic_check() -> (
  pos = player('vedantiron');

  if(
    abs(pos.x + 265) > 6 || abs(pos.z - 354) > 6,
    (
      print('Bot displaced, re-pathing');
      run('#goto -265 63 354');
    )
  );

  if(baritone('isPathing') == false,
    (
      print('Baritone stopped, restarting');
      _start_main();
    )
  );

  task(6000, _periodic_check());
);

_log_distance() -> (
  pos = player('vedantiron');

  dx = pos.x + 265;
  dz = pos.z - 354;
  dist = sqrt(dx*dx + dz*dz);

  print('Distance to farm: ' + round(dist));
  task(1200, _log_distance());
);
