# F75_Project
DATA 550 Midterm Project analyzing F75 formula and patient outcomes


## Research Question

How do children with malnutrition receiving the standard F75 formula and those receiving the modified F75 formula differ in patient outcomes (weight at stabilization and days to stabilization)?

## Team Members

Jasmine Robinson: GitHub management, README, Makefile, pull requests, and final report.

Sharifa Fatao: Patient demographics by age and sex, comparing control and treatment groups.

Odoba Okwuosa: Baseline weight and stabilization weight, comparing control and treatment groups.

Jamila Taffe: Days to stabilization, comparing control and treatment groups.

## Dataset

F75 dataset

Expected file location: data/f75_interim.csv

## Project Organization

- data/: Dataset
- code/: Team members' R scripts
- output/: Generated figures, tables, and reports
- README.md: Project documentation
- Makefile: Commands to generate reports
- config.yml: Report configurations
- report.Rmd: Final report

## Report Configurations

1. All sexes
2. Males only
3. Females only

## How to Run

After installing R and the required packages, run:

make all

make male

make female

## Collaboration

Team members develop code in separate branches or forks.

Completed code is submitted through pull requests.

Jasmine reviews and merges approved contributions into the official main branch.
