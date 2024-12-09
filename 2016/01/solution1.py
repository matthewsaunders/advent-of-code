FILENAME = "input.txt"

def num_blocks_away(directions):
  pos_x = 0
  pos_y = 0
  heading = 'N'

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

    # update poositions
    if heading == 'N':
      pos_y += blocks
    elif heading == 'E':
      pos_x += blocks
    elif heading == 'S':
      pos_y -= blocks
    else:
      pos_x -= blocks

  return abs(pos_x) + abs(pos_y)

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  directions = input.strip().split(", ")
  num_blocks = num_blocks_away(directions)

  print("answer: ", num_blocks)
