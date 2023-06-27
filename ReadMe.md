#URDF2Spatial

A repo for transforming a URDF into matlab for testing purposes. There are also testing scripts that creates a test file in matlab when given a URDF file, with associated files.

For empty submodules like URDFParser, use the command: ```git submodule update --init --recursive``

Note: This repo does not come with URDF files and those must be added for the code to run.

Commands for Running:

For running the URDF Matlab Generator:```python3 generateSpatialModel.py PATH_TO_URDF```

For running the testing script:```python3 testing/matTestGen.py PATH_TO_URDF ```