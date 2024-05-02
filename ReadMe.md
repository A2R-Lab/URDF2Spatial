# URDF2Spatial

Primarily contains code for converting between URDF and MATLAB model formats (intended for use with [spatial\v2\_extended](https://github.com/ROAM-Lab-ND/spatial_v2_extended) to check reference implementations). We also make use of GRiD's [URDFParser](https://github.com/A2R-Lab/URDFParser/tree/floating-base) as a submodule.

If `URDFParser` submodule is empty, run: ```git submodule update --init --recursive```

**Note**: This repo doesn't come with URDF files and those must be added for the code to run.

Running the URDF Matlab Generator: ```python3 generate_spatial_model.py PATH_TO_URDF [-f]```

Here, `-f` generates a floating base version of the robot described in the URDF file. The resulting MATLAB file (written in a format used by spatial\_v2) then contains an additional ``Fb``-type joint.

There are also testing scripts that create a test file in Matlab when given a URDF file, with associated files (FDab.m and HandC.m) that should be in Matlab when running the script.

Running the testing script: ```python3 matTestGen.py PATH_TO_URDF ```
