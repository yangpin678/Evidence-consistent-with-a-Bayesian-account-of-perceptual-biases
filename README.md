# Perceived 3D Slant: Sensory Cue Reliability and Bayesian Integration

## Overview

This repository contains the experimental data and analysis materials associated with a study investigating how the reliability of stereoscopic and texture information influences perceived three-dimensional (3D) surface slant.

The study evaluates a Bayesian account of perceptual biases, which proposes that sensory information is integrated with a prior favoring frontoparallel surfaces. We examine whether systematic variations in perceived slant can be explained by changes in sensory cue reliability and prior expectations, rather than by fixed biases in the interpretation of optical information.

## Experimental Design

Two experiments were conducted to investigate perceived 3D slant under systematic variations in stereo and texture cue reliability.

Participants completed two psychophysical tasks:

- **Slant estimation:** Participants reported perceived surface slant using a hand-alignment task.
- **Slant discrimination:** Participants performed a discrimination task to measure the precision of slant perception and estimate sensory cue reliability.

The experiments included the following manipulations:

- **Viewing distance:** 90 cm and 180 cm, to manipulate the reliability of stereoscopic information.
- **Surface slant:** Different simulated slants, producing systematic variations in texture cue reliability.
- **Cue availability:** Texture-only, stereo-only, and combined texture–stereo conditions.

Stereo information generally becomes less reliable at longer viewing distances, whereas texture reliability is relatively distance-invariant and increases with surface slant.

## Research Questions

The study addresses three primary questions:

1. How does the reliability of stereoscopic information influence perceptual gain in 3D slant estimation?
2. How do changes in the relative reliability of stereo and texture cues influence nonlinearities in perceived slant?
3. Can sensory cue reliabilities measured independently in a discrimination task, combined with a frontal-surface prior, quantitatively predict slant estimates?

## Bayesian Model

A Bayesian model was developed to explain how sensory information and prior expectations jointly determine perceived slant.

The model combines:

- **Sensory likelihoods:** Estimated from slant discrimination performance.
- **Sensory cue reliability:** Determines the relative contributions of stereo and texture information.
- **Prior distribution:** Favors frontoparallel surfaces.
- **Posterior estimates:** Predict perceived slant and perceptual gain.

Model predictions were compared with behavioral measurements from the slant estimation task.

## Main Findings

The principal findings were:

1. **Viewing-distance effects:** Slant estimates were approximately veridical and linear at 90 cm, but showed reduced perceptual gain at 180 cm when stereo information was less reliable.
2. **Nonlinear perceptual biases:** Nonlinearities emerged in combined texture–stereo conditions, particularly at the longer viewing distance.
3. **Reliability-dependent cue integration:** The relative influence of texture information increased as stereo reliability decreased, particularly at larger surface slants.
4. **Quantitative model predictions:** Cue reliabilities estimated from discrimination performance, combined with a frontal-surface prior, accurately predicted perceptual gains and slant estimates.

Together, these findings provide evidence consistent with a Bayesian account of 3D slant perception.

## Repository Structure

```text
├── Experiment1/
│   ├── data/
│   └── analysis/
├── Experiment2/
│   ├── data/
│   └── analysis/
└── README.md
```

- **Experiment1/**: Data and analysis materials for Experiment 1.
- **Experiment2/**: Data and analysis materials for Experiment 2.
- **data/**: Experimental behavioral measurements.
- **analysis/**: Scripts used for data processing, statistical analysis, and model evaluation.

## Data Availability

The datasets and analysis materials provided in this repository are intended to support transparency, reproducibility, and further investigation of sensory cue integration in 3D vision.

## Citation

If you use these data or analysis materials, please cite the associated manuscript:

Yang, P., et al. *Evidence Consistent with a Bayesian Account of Perceptual Biases: Cue Reliabilities Influence Mapping Between Actual and Perceived 3D Slant.*

Full publication details will be added when available.

## Contact

For questions regarding the data or analysis, please contact:

**Pin Yang, Ph.D.**

Email: youngpink678@gmail.com
