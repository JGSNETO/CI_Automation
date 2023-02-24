# CI_Automation
Snok, Zuul, Jenkins and Robot Framework. 

## Robot Framework
#### Introduction

-   Python-based framework
-   Tabular syntax for creating test cases in a uniform way
-   Results and logs in HTML format 

### Virtual Env

- Allows python to install packages in an isolated location for a particular system or application, rather than installing all packages into the same global location. 

### Test Data Section

- Settings: Importing test libraries, resource files and variables files. Defining metadata for test suites and test cases. 
- Variables: Defining variables that can be used elsewhere in the test data. 
- Test Cases: Creating test cases from avaiable keywords. 
- Tasks: Creating task using available keywords. Single file can only contain either tests or tasks. 
- Keywords: Creating user keywords from existing lower-level keywords.
- Comments: Additional comments or data. Ignored by Robot Framework. 

### Rules for parsing the data 

When robot Framework parses the test data files, it ignores:
- All data before the first test data section
- Data in the comments section
- All empty rows
- All empty cells at the end of rows when using the pipe separated format 
- All single backslashes \ when not used for escaping
- All characters following the hash character (#), when it is first character of a cell. This means hat hash marks can be used to enter comments in the test data. 


¨¨¨
*** Settings ***
Documentation      Here we have documentation for this suite.
...                Documentation is often quite long.
...
...                It can also contain multiple paragraphs.
Default Tags       default tag 1    default tag 2    default tag 3
...                default tag 4    default tag 5

*** Variables ***
${STRING}          This is a long string.
...                It has multiple sentences.
...                It does not have newlines.
${MULTILINE}       SEPARATOR=\n
...                This is a long multiline string.
...                This is the second line.
...                This is the third and the last line.
@{LIST}            this     list     is      quite    long     and
...                items in it can also be long
&{DICT}            first=This value is pretty long.
...                second=This value is even longer. It has two sentences.

*** Test Cases ***
Example
    [Tags]    you    probably    do    not    have    this    many
    ...       tags    in    real    life
    Do X    first argument    second argument    third argument
    ...    fourth argument    fifth argument    sixth argument
    ${var} =    Get X
    ...    first argument passed to this keyword is pretty long
    ...    second argument passed to this keyword is long too
¨¨¨

### Test Case Syntax 

-   Test cases are constructed in test case sections from the available keywords. 
-   Keywords can be imported from test libraries or resource files or created in the keyword section of the test case file itself

[Documentation]
    Used for specifying a test case documentation
[Tags]
    Used for tagging test cases
[Setup],[Teardown]
    Specify test setup and teardown
[Template]
    Specifies the template keyword to use. The test itself will contain only data to use as arguments to that keyword. 
[Timeout]
    Used for setting a test case timeout. Timeouts are discussed in their own section

¨¨¨

*** Test Cases ***
Test With Settings
    [Documentation]    Another dummy test
    [Tags]    dummy    owner-johndoe
    Log    Hello, world!

¨¨¨


### Using Arguments

How to actually implement user keywords and library keywords. 

## Positional arguments

Most keywords have a certain number of arguments that must always be given. In the keyword documentation this is denoted by specifying the argument names separated with a comma like first, second, third. 

¨¨¨
*** Settings ***
Library         OperatingSystem

*** Variables ***
${CURDIR}
${PATH}         ${CURDIR}/example.txt
${TEMPDIR}

*** Test Cases ***
Example
    Create Directory    ${TEMPDIR}/stuff
    Copy File    ${CURDIR}/file.txt    ${TEMPDIR}/stuff
    No Operation

¨¨¨

## Installation

- Download the last version:
```
pip install robotframework
```
- Update robotframework:
```
pip install --upgrade robotframework
```
- Uninstall robotframework
```
pip uninstall robotframework
```

## Creating Test Data

- Test cases are created in test case files
- Test cases file automatically creates a test suit containing the test cases in that file
-Test libraries: Containing the lowest-level keywords 
- Resource files with variables dna higher-level user keywords
- Variable files to provide more flexible ways to create variavles than resource files

### Test Dara Sections

- Settings: Import test libraries, resource files and variables files 
- Variables: Defining variables that can be used elsewhere in the test data
- Test Cases: Creating test cases from available keywords 
- Tasks: Creating tasks using avaiable keywords. Single file can only contain either tests or tasks. 
- Keywords: Creating user keywords from existing lower-level keywords
- Comments: Additional comments or data. Ignored by Robot Framework. 
  
### File formats

- The most common approach is using the space separeted format where pieces of the data, such as keywords and their arguments, are separeted from each others with two or more spaces. 

### Arguments

- Positional Arguments
```
*** Test Cases ***
Example
    Create Directory    ${TEMPDIR}/stuff
    Copy File   ${CURDIR}/file.txt  ${TEMPDIR}/stuff
    No Operation
```

### Tagging Test Cases

- Using tags in robot framework is a simple, yet powerfull mechanism for classifying test cases and also user keywords. 
- Tags can be used for the following purposes:
1. They are shown in test reports, logs and, of course in the test data, so they provide metadata to test cases.
2. Statistics about test cases(Total, passed, failed and skipped) are automatically collected based on them. 
3. They can be used to include and exclude as weel as to skip test cases. 

<em>Test Tags</em> in the setting section: All tests in a test case file with this setting always get specified tags. If this setting is used in a suite initialization file, all tests in child suites get these tags.

[Tags]: With each test case_ Tests get these tahs in addition to tags specified using the Test Tagas Settings.

--settag command line option: All tests tags set with this option in addition to tafs they got elsewhere. 

- Set Tags, Remove tags, fail and pass execution keywords: These builtIn keywords can be used to manipulate tags dunamically during the test execution.

## Test Setup 
