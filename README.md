# Reverse Polish Notation Calculator

## Overview

This is general purpose postfix operator interpereter. Included are two
applications of the interpereter one is a Reverse Polish Notation
calculator, and the other being a very bare-bones calculculator with a
few operators implemented.

Wherever possible, I've tried to adhere to SRP, and split out classes for lexing
input, running operations, and logging output. I've also atempted to leverage
polymorphism where possible to minimze conditions and improve readability.

Having gotten to the point where adding operations is relatively easy, and
allowed the creation of more lexers and token types, I think the next thing that
I would have wanted to do it to try putting the application behind a different
interface. Given that the Cli class was orchestrating all of the io, I'd imagine
that the application could be extened for other applications, like web, without having 
to modify much code.

There are still some places where I might clean things up more, especially if I
were to continue to add functionality. The lexing regexs are far from clear in
intent, and there is shared knowledge between the lexer and the tokens about
what the operation types are.

I chose to do this in ruby for a number of reasons. Firstly, I know it's command
line and IO systems better than any other langunge. Also, I find it easy to
organize and refactor code in ruby. Lasty, it's command line utilities and
standard library option parser make it an obvious choice for command line
aplications.

## Running The Code

There are no dependies. This code will run on ruby 2+. There are some warning on
Ruby versions less than 2.3.

### Installation

```
git clone git@github.com:joeyjoejoejr/rpn_calculator.git
```

Command Help

`./bin/rpn_calculator -h`

### Usage: Revere Polish Notation Calculator

**Supported Operators:** +, -, \*, /, %, \*\*

`./bin/rpn_calculator`

`echo "1 1 +" | ./bin/rpm_calculator #=> 2`

`./bin/rpm_calculator instructionfile instructionfile2 ...`

```
rpn > 1 1 +
2.0
rpn > 1 1 -
0.0
rpn > 2 2 *
4.0
rpn > 1 2 /
0.5
rpn > 12 5 %
2.0
rpn > 2 3 **
16.0

rpn > 1
1.0
rpn > 1
1.0
rpn > +
2.0

rpn > q
```

### Usage: Postfix String Calculator

**Supported Operators:** !concat, !sentence, !capitalize, !reverse

`./bin/rpn_calculator -t string`

```
rpn> hello world !concat
helloworld
rpn> hello world !sentence
hello world.
rpn> hello !capitalize
Hello
rpn> hello !reverse
olleh
rpn> /q
```

## Running The Tests

To run the tests

`bundle install`
`bundle exec rspec`
