from URDFParser import URDFParser
from util import parseInputs
import numpy as np
import sys
import random

'''
Generating a test file for checking values of aba, H, and inv of H in Matlab
'''
#Function to generate random array of joint angles for q
def getRandQ(n):
    random.seed(14)
    q = []
    for _ in range(n):
        q.append(random.uniform(-1, 1))
    return q

def generate_matlab_test(robot):
    
    ##setting changing vars for q and number of joints
    n = robot.get_num_joints()
    print("this is n:",n)
    q = getRandQ(n)
    print("Randomly selected values for q:\n",q)
       
    ##Opening the file and writing for the robot model
    original_stdout = sys.stdout
    f = open(f"test.m",  "w")
    sys.stdout = f
    print(f"my_model = {robot.name}();")

    ##Creating qdd and running it in FDab
    print()
    print(f"q = [", end="")
    print(*q, "];")
    print(f"qdd = FDab(my_model, q, zeros({n}), zeros({n}));")
    print(f"disp('testing {robot.name}');")
    print(f"disp('qdd'); disp(qdd);")

    ##Creating H and inv of H matrices
    print()
    print(f"[H, C] = HandC(my_model, q, zeros({n}));")
    print(f"disp('H'); disp(H);")
    print(f"disp('Inv of H'); disp(inv(H));")
    sys.stdout = original_stdout
    f.close()

if __name__ == "__main__":
    URDF_PATH, DEBUG_MODE, FILE_NAMESPACE_NAME = parseInputs()

    parser = URDFParser()
    robot = parser.parse(URDF_PATH)

    generate_matlab_test(robot)
    print("Matlab test file has been created and saved to test.m!")