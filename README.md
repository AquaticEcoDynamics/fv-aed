
![image](fv_banner.png)

# FV-AED 
[![Latest release](https://badgen.net/github/release/Naereen/Strapdown.js)](https://github.com/AquaticEcoDynamics/fv-aed/releases)
[![Linux](https://svgshare.com/i/Zhy.svg)](https://svgshare.com/i/Zhy.svg)
[![Windows](https://svgshare.com/i/ZhY.svg)](https://svgshare.com/i/ZhY.svg)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

<br>

<a href="url"><img src="aed-icon2.png" align="right" width="50" ></a> FV-AED is the water quality model [AED](https://aquaticecodynamics.github.io/aed-science/index.html) compiled as a plugin ready for linking with the 3D finite volume hydrodynamic model *TUFLOW-FV*. 

<br>

## Repository organisation

The repository includes:

- `binaries` : model pre-compiled executables for linux and windows.
- `fv-source` : model source code, including required AED libraries (libaed-fv, libaed-water and libaed-benthic) as linked sub-modules.
- `fv-examples` : example simulations for running a TUFLOW-FV + AED simulation, including all required input files.
- `workflows` : github workflows for automated compilation and testing.

<br>

## Citing this code

[![DOI](https://zenodo.org/badge/520823025.svg)](https://zenodo.org/badge/latestdoi/520823025)

Users may need to cite the AED model in general, or a specific model code package/bundle/version.

Citing a specific code bundle, please use the appropriate DOI, eg.:

*Hipsey, M.R., Boon, C., Paraska, D., Bruce, L. and Huang, P., (2022). AquaticEcoDynamics/fv-aed: v2.2.1 (v2.2.1). Zenodo. https://doi.org/10.5281/zenodo.7047676.*

Citing the AED model:

*Hipsey, M.R., ed. (2022) Modelling Aquatic Eco-Dynamics: Overview of the AED modular simulation platform. Zenodo. https://doi.org/10.5281/zenodo.6516222.*
<br>

## Getting the latest pre-compiled version

For users who only need access to a model executable plugin, the executable for your chosen platform can be downloaded without getting the full repository. Simply navigate to the binaries/os folder, click on the relevant file (e.g., `tuflow_external_wq_2.2.1.zip`) and click the "*download*" button on the right.

<br>

## Cloning the repo with all sub-module code

To access the full repository, including the model examples, the repository must be cloned or downloaded in full. Note that a basic clone will not include the code/files in the linked sub-modules, so an extra argument is needed `--recurse-submodules`

### Cloning the latest code
```
git clone --recurse-submodules https://github.com/AquaticEcoDynamics/fv-aed.git
```

### Cloning a particular tag
```
git clone --recurse-submodules -b v2.2.1 https://github.com/AquaticEcoDynamics/fv-aed.git
```

<br>

## Additional information

See repository [Wiki](https://github.com/AquaticEcoDynamics/fv-aed/wiki) for additional information on getting started using FV-AED, working with the repository, and updating or adding new example water-bodies.

<br>

[<img src="aed.png" alt="AED" width="100"/>](https://aquatic.science.uwa.edu.au)


