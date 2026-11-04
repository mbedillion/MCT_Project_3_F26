# MCT-F26 Project 3

MATLAB R2025a backend for the Project 3 optimal-control assignment, migrated
from the supplied Webots R2021a world to Webots R2025a while retaining the
assignment trajectory, vehicle behavior, displays, plots, and grading rules.
Python is not required by the converted project.

## Requirements

- Webots R2025a
- MATLAB R2025a with Control System Toolbox
- Windows: MATLAB Support for MinGW-w64 C/C++ Compiler
- macOS: Xcode Command Line Tools with a MATLAB-supported Clang compiler
- Ubuntu Linux: a GCC release supported by the installed MATLAB version

The controller selects `driver.dll` on Windows, `libdriver.dylib` on macOS,
and `libdriver.so` on Linux. macOS and Ubuntu support follows the same code path
as Project 1 but remains runtime-unverified. Do not use the Linux Snap package,
whose sandbox does not support MATLAB controllers.

## Clone and run

```text
git clone <repository-url> MCT-F26-Project3
cd MCT-F26-Project3
```

Open `worlds/automotive_new.wbt` in Webots R2025a and press **Run**. The
tractor uses controller `main_matlab`; Webots launches MATLAB and runs
`controllers/main_matlab/main_matlab.m`. Do not run that file directly because
Webots must establish the controller connection first.

If Webots does not detect MATLAB, set **Tools > Preferences > General > MATLAB
command** to the MATLAB R2025a executable. Preserve the repository folder
structure and reset the simulation after controller edits. If startup fails,
confirm `WEBOTS_HOME` is set by Webots, install the MinGW support package, and
clear stale Webots/MATLAB generated library files from the user temporary
directory. Do this only after Webots and MATLAB have exited so no thunk DLL
remains locked.

## Assignment work

Read the Fall 2026 directions, `MCT_Project_3_2026.pdf`, in full. Edit only:

```text
controllers/main_matlab/your_controller.m
```

Implement both required lateral controllers in the labeled section:

- an infinite-horizon discrete LQR controller;
- a finite-horizon MPC controller that applies the first computed input.

Use the `controllerMode` property to select `lqr` or `mpc`. Implement and tune
the longitudinal controller in its labeled section. The initial zero-force,
zero-steering values are safe placeholders. Do not change the runner, grader,
trajectory, world, or helper files for assignment work.

For each controller, full credit requires a completed loop within 200 s,
maximum deviation no greater than 8.0 m, average deviation no greater than
4.0 m, and average steering-angle change no greater than 0.025 rad/timestep. Completion
prints grading details in the Webots/MATLAB terminal and saves
`controllers/main_matlab/controller_results.png`. The results window remains
open until the student closes it.

Instructor solutions, generated plots, scores, logs, caches, and Webots UI
state are intentionally excluded from Git.

## R2025a compatibility

The migrated world declares its R2025a PROTO dependencies explicitly. Road,
building, forest, playset, and primitive coordinates follow R2025a conventions.
Project-local front and rear wheel PROTOs preserve the original joint frames
while rotating only wheel geometry to the R2025a primitive-axis convention.
The MATLAB backend uses Webots' Controller API plus the vehicle Driver library.
