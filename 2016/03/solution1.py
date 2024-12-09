FILENAME = "input.txt"

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  triangles = input.strip().split("\n")

  num_valid = 0
  for tri in triangles:
    sides = tri.split()
    sides = [int(side) for side in sides]
    sides.sort()

    if sides[0] + sides[1] > sides[2]:
      num_valid += 1

  print("answer: ", num_valid)
