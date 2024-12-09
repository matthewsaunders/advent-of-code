FILENAME = "input.txt"

if __name__ == "__main__":
  with open(FILENAME) as f:
    input = f.read()

  lines = input.strip().split("\n")
  triangles = []
  triA = []
  triB = []
  triC = []

  for index, line in enumerate(lines):
    if index % 3 == 0 and index != 0:
      triangles.append(triA)
      triangles.append(triB)
      triangles.append(triC)
      triA = []
      triB = []
      triC = []

    nums = line.split()
    triA.append(nums[0])
    triB.append(nums[1])
    triC.append(nums[2])

  triangles.append(triA)
  triangles.append(triB)
  triangles.append(triC)

  num_valid = 0
  for sides in triangles:
    sides = [int(side) for side in sides]
    sides.sort()

    if sides[0] + sides[1] > sides[2]:
      num_valid += 1

  print("answer: ", num_valid)
