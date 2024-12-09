FILENAME = "input.txt"

pos_x = 1
pos_y = 1

row_maxs = [2, 3, 4, 3, 2]
row_mins = [2, 1, 0, 1, 2]

def get_code(instruction):
  global pos_x, pos_y

  for step in list(instruction):
    if step == 'U':
      pos_y -= 1
    elif step == 'D':
      pos_y += 1
    elif step == 'R':
      pos_x += 1
    elif step == 'L':
      pos_x -= 1

  return str((3 * pos_y) + (pos_x + 1))

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  instructions = input.strip().split("\n")
  codes = [get_code(inst) for inst in instructions]
  answer = ''.join(codes)

  print("answer: ", answer)
