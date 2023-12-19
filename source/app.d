import argparse;

import std.algorithm;
import std.string;
import std.stdio;
import std.file;
import std.exception;
import std.range;

struct Args
{
	@PositionalArgument(0)
	string filename;

	@(NamedArgument
			.Validation!((int value) {
				if (value > 0)
					return true;
				"cccut: fields are numbered from 1".writeln;
				return false;

			})
			.Required()
	)
	int f;
}

int main(string[] argv)
{
	Args args;

	if (!CLI!Args.parseArgs(args, argv[1 .. $]))
		return 1;

	try
	{
		File file = File(args.filename, "r");
		foreach (i, line; file.byLine().map!(a => a.split("\t")).enumerate)
		{
			if (line.length >= args.f)
			{
				line[args.f - 1].writeln;
			}
		}
	}
	catch (ErrnoException)
	{
		writefln("cccut: %s: No such file or directory", args.filename);
	}

	return 0;
}
