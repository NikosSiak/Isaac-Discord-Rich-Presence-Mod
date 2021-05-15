local difficulties = {
  'Normal',
  'Hard',
  'Greed',
  'Greedier'
}

function GetDifficultyName(id)
  return difficulties[id + 1] or 'iamerror'
end
