# Neobis_iOS_Calculating

## Table of contents
* [Description](#description)
* [Getting started](#getting-started)
* [Usage](#usage)
* [Running the Tests](#running-the-tests)
* [Workflow](#workflow)
* [Design](#design)
  
## Description 

This is the fifth project in Neobis Club. On the fifth week I created a calculator with its basic operations by using MVVM pattern. As model enum of buttons, by which we can define text and background colors. In View, we created custom buttons for keyBoardStackView and UILabel to display our calculation to User. And ViewModel, with main core of logic.

## Getting started 

- Make sure you have the XCode version 14.0 or above installed on your computer
- Download the project files from the repository
- Install CocoaPods
- Run pod install so you can install dependencies in your project
- Open the project files in Xcode
- Run the active scheme by using any emulator

## Usage

As in many calculators, we can perform arithmetic equations. First of all, User have to print the first number, then specify the operation and at the end the second number to get an answer. Also we can clear numbers by clicking button "C" or "AC", if User wants to remove all. Another way to remove number is by swiping label to left or to right.

## Running the Tests

I tested auto-layout functionality by running different versions of apps. Then to test the main logic, created several interesting test-cases with zeroes, very big integers and fractionals.

## Workflow

- Reporting Bugs:
    If you come across any bugs while using this project, please report us by creating an issue on the Github repository
- Submitting pull requests:
    If you have a bug fix or a new feature for project, feel free to submit a pull request. Make sure that your changes are well-tested.
- Improving documentation:
    If you notice any errors or mistakes in the documentation, you can submit pull request with your changes
- Providing feedback:
    If you have any feedback, you can send an email to project maintainer

## Design

Below is a screenshot of how application looks like on iphone 14:

<img width="411" alt="Снимок экрана 2023-11-22 в 03 46 35" src="https://github.com/KryaKa57/Neobis_iOS_Calculating/assets/132449744/c06c9b47-9981-4f07-bbe3-24bd8c6acb58">
<img width="410" alt="Снимок экрана 2023-11-22 в 03 47 10" src="https://github.com/KryaKa57/Neobis_iOS_Calculating/assets/132449744/ce3adf03-54cd-4d02-a4c2-04434038b4fd">
<img width="413" alt="Снимок экрана 2023-11-22 в 03 48 13" src="https://github.com/KryaKa57/Neobis_iOS_Calculating/assets/132449744/494df77b-99a4-4480-ba2d-b231ed85ee7d">

