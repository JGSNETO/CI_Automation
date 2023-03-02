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

- A test setup is something that is executed before a test case.
- A test teardown is executed after a test case. The test teardown is special in two ways. First of all, it is executed also when a test case fails, so it can be used for clean-up activities that must be done regardeless of the test case status. In addition, all the keywords in the teardown are also executed even if one of them fails. This continue on failure functionality can be used also with normal keywords, but inside teardowns it is on by default. 

```
*** Settings ***
Test Setup       Open Application    App A
Test Teardown    Close Application

```

### Creating test suites

- Robot framework test cases are created in test case files, which can be organized into directories. Tehse files and directories create a hierarchical test suite structure. Same concepts apply also when creating tasks, but the terminology differs. 

## Test case files 

- Robot Framework test cases are created using test case files. Such a file automatically creates a test suite from all the test cases it contains. There is no upper limit for how many test cases there can be, but it is recommended to have less than ten, unless the data-driven approach is used, where one test case consists of only one high-level keyword. 

- The following settings in te setting section can be used to customize the test suite:

```
Documentation
    Used for specifying a test suite documentation
Metadata
    Used for setting free test suite metadata as name-value pairs.
Suite Setup, Suite Teardown
    Specify suite setup and teardown.
```

### Using Test Library

- Test libraries contain those lowest-level keywords, oftern called library keywords, which actuall interact with the system under test. All test cases always use keywords from some library, often through higher-lvel user keywords.   

- Importing libraries:
```
*** Settings ***
Library OperatingSystem
Library my.package.TestLibrary
Library ${LIBRARY}
```
- Using physical path to library 
```
*** Settings ***
Library realive/path/PythonDirLib
Library ${RESOURCES}/Example.class
```

## Variables 

- Robot Framework has it own variables that can be used as scalars, lists or dictionaries using sytax ${SCALAR}, @{LIST} and &{DICT}. Environmental variables %{var}.
- Variables are case sensetive. Is a good pratice to use capital letters for global variables and small letters with local variables that are only available in certain test cases. 

### Scalar variable syntax
```
Constants
    Log    Hello
    Log    Hello, world!!

Variables
    Log    ${GREET}
    Log    ${GREET}, ${NAME}!!
```

### List variable syntax
- List are expanded and individual items are passed in as separate arguments. 
```
*** Test Cases ***
Constants
    Login    robot    secret

List Variable
    Login    @{USER}
```
- using a variable as a list requires its value to be a python list or list-like object.
```
*** Test Cases ***
Nested container
    ${nested} =    Evaluate    [['a', 'b', 'c'], {'key': ['x', 'y']}]
    Log Many    @{nested}[0]         # Logs 'a', 'b' and 'c'.
    Log Many    @{nested}[1][key]    # Logs 'x' and 'y'.

Slice
    ${items} =    Create List    first    second    third
    Log Many    @{items}[1:]         # Logs 'second' and  'third'.
```

### Dictionary Variable Syntax

- So,oöaröy a variable containing a Python dictionary or a dictionary-like object can be used as a dictionary variable like &{EXAMPLE}. In pratice this means that the dictionary is expanded and individual items are passed as named arguments to the keyword. 

```
*** Test Cases ***
Constants
    Login    name=robot    password=secret

Dict Variable
    Login    &{USER}
```

  

