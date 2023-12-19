# cccut

## Write Your Own cut Tool

This challenge is to build your own version of the Unix command line tool cut!

The Unix command line tools are a great metaphor for good software engineering and they follow the Unix Philosophies of:

Writing simple parts connected by clean interfaces - each tool does just one thing and provides a simple CLI that handles text input from either files or file streams.
Design programs to be connected to other programs - each tool can be easily connected to other tools, via files and streams, to create incredibly powerful compositions.
Following these philosophies has made the simple unix command line tools some of the most widely used software engineering tools which can be chained together to create far more complex and powerful set of tools that you’d expect.

You can read more about the Unix Philosophy in the excellent book [The Art of Unix Programming](http://www.catb.org/~esr/writings/taoup/html/).

### The Challenge - Building cccut

The functional requirements for cccut are concisely described by it’s man page - give it a go in your local terminal now:

```shell
man cut
```

The TL/DR version is: cccut - cuts out the selected portions from each line in a file.

#### Step 0

In this introductory step you’re going to set your environment up ready to begin developing and testing your solution.

I’ll leave you to setup your IDE / editor of choice and programming language of choice. After that here’s what I’d like you to do to be ready to test your solution, download the text from [my Dropbox](https://www.dropbox.com/s/hpbma5alue0du34/challenge-cccut.zip?dl=0).

#### Step 1

In this step your goal is to implement a simple version of cccut that will open the provided tab separated file and print out the second field (`-f2`) from each line. The result should look something like this:

```shell
cccut -f 2 sample.tsv
f1
1
6
11
16
21
```

#### Step 2

```shell
cccut -f1 --delimiter , fourchords.csv | head -n5
Song title
"10000 Reasons (Bless the Lord)"
"20 Good Reasons"
"Adore You"
"Africa"
```

Here we again seeing how the Unix command line tools can be chained (piped) together to create more powerful data processing pipelines. With the head command allowing us to limit the output to the first five lines.

Then check we still default to a tab:

```shell
cccut -f1 sample.tsv
f0
0
5
10
15
20
```

#### Step 3

In this step your goal is to add support for the -f option. This option specifies a list of fields to be printed out. Output fields are separated by a single occurrence of the field delimiter character.

The field list is a comma or whitespace separated list of fields, i.e. `-f1 2`. The first field is field number 1.

Here’s a couple of tests on this:

```shell
cccut -f1 2 sample.tsv
f0      f1
0       1
5       6
10      11
15      16
20      21
```

&

```shell
cccut --delimiter , -f1 2 fourchords.csv | head -n5
Song title,Artist
"10000 Reasons (Bless the Lord)",Matt Redman and Jonas Myrin
"20 Good Reasons",Thirsty Merc
"Adore You",Harry Styles
"Africa",Toto
```

#### Step 4

In this step your goal is to support reading from the standard input stream if no filename is provided or if the single dash is provided ‘-’.

```shell
tail -n5 fourchords.csv | cccut --delimiter , -f1 2
"Young Volcanoes",Fall Out Boy
"You Found Me",The Fray
"You'll Think Of Me",Keith Urban
"You're Not Sorry",Taylor Swift
"Zombie",The Cranberries
```

or

```shell
tail -n5 fourchords.csv| cccut --delimiter , -f1 2 -
"Young Volcanoes",Fall Out Boy
"You Found Me",The Fray
"You'll Think Of Me",Keith Urban
"You're Not Sorry",Taylor Swift
"Zombie",The Cranberries
```
