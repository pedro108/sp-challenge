# Smart Pension Technical Challenge
Author: Pedro de Jesus \<pedro.henrique.108@gmail.com\>

## Tech Stack
- **Ruby Version:** MRI 2.7.1
- **Automated Testing:** RSpec
- **Linter:** Rubocop
- **Dependency Manager:** Bundler

## About
This is a submission of Smart Pension coding challenge, that consists of a log parser that returns a list of page views by webpage, sorted in descending order, and a list of unique page views by webpage, also sorted in descending order.

The output is formatted as a table in the console terminal.

**Note:** all commands must be executed at the root of the project.

## Installing dependencies
Before being able to run the script, run tests or the linter, the program dependencies must be installed with the following command:

```bash
$ bundle install
```

## Running the script
The main script is located at `./bin/log-parser` and it must receive the path to the log file as the first argument.

```bash
$ ./bin/log-parser webserver.log
```

## Automated Testing
The script that runs automated tests is powered by `rspec` gem and is located at `.bin/run-tests`. It accepts RSpec arguments. 

```bash
# Execute all automated tests
$ ./bin/run-tests

# Execute only main_spec.rb
$ ./bin/run-tests --pattern src/spec/log_parser/main_spec.rb
```

## Linting
The linter script is powered by `rubocop` gem and is located at `./bin/run-linter`. It accepts Rubocop arguments.

```bash
# Just run the linter
$ ./bin/run-linter

# Run the linter with autoformat
$ ./bin/run-linter -A
```
