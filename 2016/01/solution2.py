FILENAME = "input.txt"

def num_blocks_away(directions):
  pos_x = 0
  pos_y = 0
  heading = 'N'
  locations = set()

  for dir in directions:
    dir_change = dir[:1]
    blocks = int(dir[1:])

    # update heading first
    if heading == 'N':
      heading = 'W' if dir_change == 'L' else 'E'
    elif heading == 'E':
      heading = 'N' if dir_change == 'L' else 'S'
    elif heading == 'S':
      heading = 'E' if dir_change == 'L' else 'W'
    else:
      heading = 'S' if dir_change == 'L' else 'N'

    for _ in range(blocks):
      # update positions
      if heading == 'N':
        pos_y += 1
      elif heading == 'E':
        pos_x += 1
      elif heading == 'S':
        pos_y -= 1
      else:
        pos_x -= 1

      loc = f'{pos_x},{pos_y}'

      if loc in locations:
        return abs(pos_x) + abs(pos_y)

      locations.add(f'{pos_x},{pos_y}')

  return None

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  directions = input.strip().split(", ")
  num_blocks = num_blocks_away(directions)

  print("answer: ", num_blocks)
