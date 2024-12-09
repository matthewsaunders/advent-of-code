FILENAME = "input.txt"

pos_x = 1
pos_y = 1

def get_code(instruction):
  global pos_x, pos_y

  for step in list(instruction):
    if step == 'U' and pos_y > 0:
      pos_y -= 1
    elif step == 'D' and pos_y < 2:
      pos_y += 1
    elif step == 'R' and pos_x < 2:
      pos_x += 1
    elif step == 'L' and pos_x > 0:
      pos_x -= 1

  return str((3 * pos_y) + (pos_x + 1))

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  instructions = input.strip().split("\n")
  codes = [get_code(inst) for inst in instructions]
  answer = ''.join(codes)

  print("answer: ", answer)
