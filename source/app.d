import argparse;

import std.algorithm;
import std.string;
import std.stdio;
import std.file;
import std.exception;
import std.range;

struct Args
{
	@(PositionalArgument(0).Optional())
	string filename = "stdin";

	@(NamedArgument(["fields", "f"])
			.Validation!((int value) {
				if (value > 0)
					return true;
				"cccut: fields are numbered from 1".writeln;
				return false;

			})
			.Required()
	)
	int[] fields;

	@(NamedArgument(["delimiter", "d"]))
	char delimiter = '\t';
}

int main(string[] argv)
{
	Args args;

	// Allow trailing '-'
	if (argv[$ - 1] == "-")
	{
		argv = argv[0 .. $ - 1];
	}

	if (!CLI!Args.parseArgs(args, argv[1 .. $]))
		return 1;

	try
	{
		File file = args.filename == "stdin" ? stdin : File(args.filename, "r");
		foreach (elements; file.byLine().map!(a => a.split(args.delimiter)))
		{
			args.fields.map!(idx => (idx <= elements.length ? elements[
						idx - 1
					] : "")).join(args.delimiter).writeln;

		}
	}
	catch (ErrnoException)
	{
		writefln("cccut: %s: No such file or directory", args.filename);
	}

	return 0;
}
